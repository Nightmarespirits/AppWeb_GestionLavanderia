

/* global Vue */

(async function(){
     var fechaActual = new Date();
     var dia = fechaActual.getDate();
     var mes = fechaActual.getMonth() + 1; 
     var anio = fechaActual.getFullYear();
     var fechaFormateada = (dia < 10 ? '0' + dia : dia) + '/' + (mes < 10 ? '0' + mes : mes) + '/' + anio;
     
     try {
         const response = await fetch('/Web_SistemaLavanderiaControl_SLC/sUbigeo');
         const data = await response.json();
         //Transformar la data
         const transformData = (data) => {
            const result = {};

            data.forEach(([departamento, provincia, distrito]) => {
              if (!result[departamento]) {
                result[departamento] = {};
              }
              if (!result[departamento][provincia]) {
                result[departamento][provincia] = [];
              }
              result[departamento][provincia].push(distrito);
            });

            return result;
         };
         
        const dataSerializada = transformData(data);
     
        new Vue({
            el: '#formRegClientes',
            data: {
                departamentos: dataSerializada,
                selectedDepartamento: '',
                selectedProvincia: '',
                selectedDistrito: '',
                provincias: {},
                distritos: [],
                fechaActual : fechaFormateada,
                selectedOption : null
            },
            mounted() {
                //Inicializar todos los select 2
                $(this.$el).find('.select2').select2();

                // Capturar el evento change de select2 para el departamento select
                $(this.$el).find('#selectDep').on('change', (event) => {
                    this.selectedDepartamento = event.target.value;
                    this.onDepartamentoChange(event.target.value);
                });
                
                // Capturar el evento change de select2 para la provincia select
                $(this.$el).find('#selectProv').on('change', (event) => {
                    this.selectedProvincia = event.target.value;
                    this.onProvinciaChange(event.target.value);
                });
            },
            methods: {
                onDepartamentoChange(value) {
                    console.log('Seleccion dep cambiada:', value);
                    this.selectedProvincia = '';
                    this.selectedDistrito = '';
                    this.provincias = this.departamentos[this.selectedDepartamento] || {};
                    this.distritos = [];
                },
                onProvinciaChange(value) {
                    console.log('Seleccion prov cambiada:', value);
                    this.selectedDistrito = '';
                    this.distritos = this.provincias[this.selectedProvincia] || [];
                },
                renderImg(event){
                    console.log("called" + event)
                    var reader = new FileReader();
                    reader.onload = function() {
                        var output = document.getElementById('previewImg');
                        output.src = reader.result;
                    };
                    reader.readAsDataURL(event.target.files[0]);
                }
            }
        });
         
        

        
        
     } catch(e) {
         console.error("Error en la funcion asincrona registroclientes");
     }

     //Invocar a reservationDate usando JQuery

    $('#reservationdate').datetimepicker({
        format: 'L'
    });
    $('#fecIncContrato').datetimepicker({
        format: 'L'
    });
    $('#fecTermContrato').datetimepicker({
        format: 'L'
    });
 })();
 
