
/* global Swal */

(async function () {
  console.log("LLamando funcioon asincrona");
  try {
    const response = await fetch('/Web_SistemaLavanderiaControl_SLC/Servicioslet');
    const data = await response.json();
    
    /* Extrae toda la columna servicios y los filtra  */
    var tipoServicios = data.map( elm => elm[0] + "(" + elm[1] + " dias)").filter((elm,i,arr) => arr.indexOf(elm) === i);
    var tipoPrendas = data.map(elm => elm[0] + ", " + elm[2]).filter((elm,index,arr)=>arr.indexOf(elm) === index);
    
    
    /**(por implementar) AQUI DEBEMOS EVALUAR con una condicional SI SE ESTA USANDO LOS DESCUENTOS*/
    var prendas = data.map(elm => elm[3] + " S/. " +elm[4] );
    
    //Creacion del Componente TreeItem
    var TreeItem = {
    name: 'TreeItem', 
    props: {
      model: Object
    },
    data() {
      return {
        isOpen: false
      };
    },
    computed: {
      isFolder() {
        return this.model.children && this.model.children.length;
      }
    },
    methods: {
      toggle() {
        if (this.isFolder) {
          this.isOpen = !this.isOpen;
                      
        }
      },
      clickItem(event) {
            // Emitir un evento personalizado con el nombre 'agregarDetalle' 
            this.$emit('item-clicked', event);

        }
    },
    template: `
    <li >
      <div
        :class="{ divTipoPrendas: isFolder }"
        @click="isFolder ? toggle() : clickItem($event)">
        {{ model.name }}
        <span v-if="isFolder">[{{ isOpen ? '-' : '+' }}]</span>
      </div>
      <ul v-show="isOpen" v-if="isFolder">
        <!--
          A component can recursively render itself using its
          "name" option (inferred from filename if using SFC)
        -->
        <tree-item
          class="item" @item-clicked="clickItem($event)"
          v-for="(model, index) in model.children"
          :key="index" 
          :model="model" >
        </tree-item>
      </ul>
    </li>
    `
  };
    
    //Instancia TreeItem(Tendra los datos de servicios tipo de servicios y prendas)
    var serviciosUnicos = {};

    // Iteramos sobre los datos para agregar los nombres únicos de los servicios al objeto temporal
    data.forEach(item => {
        serviciosUnicos[item[2]] = true;
    });

    // Filtramos los nombres únicos de los servicios y los convertimos en la estructura deseada
    var ListTreeData = Object.keys(serviciosUnicos).map(servicio => {
        // Filtramos los elementos de datos correspondientes al servicio actual
        var elementosFiltrados = data.filter(item => item[2] === servicio);
        // Creamos un objeto con el servicio y sus prendas
        return {
            name: servicio,
            children: elementosFiltrados.map(item => ({ name: item[3] + " S/. " +item[4] })) // Convertimos las prendas al formato deseado
        };
    });

    //Hasta aqui treeDAta es una lista de todos los datos para el componente treeItem ahora solo tenemos que iterar 
    //treedatas y crear un nuevo treeItem por cada treeDAta
    
    
    var fechaActual = new Date();
    var dia = fechaActual.getDate();
    var mes = fechaActual.getMonth() + 1; 
    var anio = fechaActual.getFullYear();
    // Obtener los componentes de la hora actual
    var hora = fechaActual.getHours();
    var minutos = fechaActual.getMinutes();
    var segundos = fechaActual.getSeconds();
    // Formatear la fecha y hora actual como texto
    var fechaFormateada = (dia < 10 ? '0' + dia : dia) + '/' + (mes < 10 ? '0' + mes : mes) + '/' + anio;

    var horaFormateada = (hora < 10 ? '0' : '') + hora + ':' + (minutos < 10 ? '0' : '') + minutos + ':' + (segundos < 10 ? '0' : '') + segundos;
    

    
    //Consultar datos de sesion en el local storage
    let nameParsed = "";
    let empDoc = "";
    if(window.sessionStorage.getItem('session')){
        let session = JSON.parse(window.sessionStorage.getItem('session'));
        nameParsed = session.nombres + " " + session.apellidos;
        empDoc = session.numDoc;
    }else{
        console.log("Vue msg: No se encontraron datos de inicio de sesion");
    }
       

    
    /* Creación del template Vue */
    new Vue({
        el: '#aplicacion',
        components:{
            TreeItem
        },
        data() {
            return {
                ListTreeData,
                username: nameParsed,
                empDocId: empDoc,
                fecha: fechaFormateada,
                tiempoDemora: 1,
                fechaEntrega: '',
                hora: horaFormateada,
                subTotal: '',
                tipoServicios: tipoServicios,
                detalles: [],
                tipoPrendas:tipoPrendas,
                prendas: prendas,
                total: 0,
                acuenta: 0,
                saldo: 0
            };
        },
        methods: {
            
            agregarDetalle(event) {
                var prenda = event.target.textContent;
                var prendDetall = prenda.split('S/.');
                this.detalles.push({
                    prenda: prendDetall[0],
                    precio: prendDetall[1],
                    cantidad:"1",
                    tipoServ: document.getElementById("tipoServ").value
                    
                });
              
            },
            delDetalle(index) {
                this.detalles.splice(index, 1);
            },
            filterElems(){
                //reordena la lista de prendas de acuerdo al ingreso de texto
                let itemsContainer = document.getElementById('itemsContainer');
                let items = itemsContainer.getElementsByClassName('ul-treeItems');
                
                const filter = document.getElementById('searchInput').value.toLowerCase();

                for (let i = 0; i < items.length; i++) {
                    let item = items[i];
                    if (item.textContent.toLowerCase().includes(filter)) {
                        item.classList.remove('hidden');
                    } else {
                        item.classList.add('hidden');
                    }
                }
            },
            fillCliente(e){
                
                //Coloca datos del cliente a partir de la busqueda en la tabla clientes
                const clienteFullname = document.getElementById('buscarCliente');
                const cliDocIdentidad = document.getElementById('cliDocIdentidad');
                const clienteEmail = document.getElementById('clienteEmail');
                const clienteDireccion = document.getElementById('clienteDireccion');

                const target = e.target;
                const fila = target.closest('tr');

                if(fila && fila.parentNode.tagName === 'TBODY'){
                    const columns = fila.getElementsByTagName('td');
                    if(columns.length > 0){
                        clienteFullname.value = columns[0].textContent;
                        cliDocIdentidad.value = columns[2].textContent;
                        clienteEmail.value = columns[3].textContent;
                        clienteDireccion.value = columns[4].textContent;
                    }
                }
            },
            printFact(e){
                //Evento que toma los valores de la orden y detalles de la orden y lo envia al servidor para guardar Data e imprimir la factura
                e.preventDefault();

                const url = '/Web_SistemaLavanderiaControl_SLC/orders';
                let nroOrden = document.getElementById("nroOrden").value;
                let docIdUsuario = document.getElementById("empDocIdentidad").value;
                let docIdCliente = document.getElementById("cliDocIdentidad").value ;
                let fecRecep = document.getElementById('fecRecep').value;
                let fecEntrega = document.getElementById('fecEntrega').value;
                let horaEntrega = document.getElementById('horaEntrega').value;
                let aCuenta = document.getElementById('aCuenta').value;


                let tabla = document.getElementById('tablaDetalles');
                
                //Objeto que contendra todos los datos del ingreso de orden de servicio
                const dataOrden = {
                    nroOrden : nroOrden,
                    docIdUsuario : docIdUsuario,
                    docIdCliente : docIdCliente,
                    fecRecep : fecRecep,
                    fecEntrega : fecEntrega,
                    horaEntrega : horaEntrega,
                    aCuenta : aCuenta,
                    accion : "printFactura",
                    detalles:[]
                };

                for(let i = 1; i < tabla.rows.length; i++){
                    fila = tabla.rows[i];

                    let dtl = {
                        numero : fila.cells[1].innerText,
                        cantidad : fila.cells[2].children[0].value,
                        servicio : fila.cells[3].innerText.replace(/\s*\([^)]*\)\s*/, ''),//Formatea: Elimina el contenido entre parentésis
                        prenda : fila.cells[4].innerText,
                        precio : fila.cells[5].innerText,
                        subtotal : fila.cells[6].innerText,
                        observaciones : fila.cells[7].children[0].value

                    };
                    dataOrden.detalles.push(dtl);

                }
                

                const options = {
                    method : 'POST',
                    headers : {
                        'Content-Type': 'application/json' 
                    },
                    body : JSON.stringify(dataOrden)
                };
                console.log("DatosEnviados: " + JSON.stringify(dataOrden));
                //Mostrar alerta sweet alert para confirmar la impresion
                Swal.fire({
                  title: "Seguro que desea Imprimir?",
                  text: "Esta accion no se puede revertir",
                  icon: "warning",
                  showCancelButton: true,
                  confirmButtonColor: "#3085d6",
                  cancelButtonColor: "#d33",
                  confirmButtonText: "Imprimir"
                  
                }).then((result) => {
                  if (result.isConfirmed) {
                    //mostrar cargador de impresion timmer
                    Swal.fire({
                        title: 'Cargando...',
                        html: 'Por favor, espere mientras se completa la operación.',
                        allowOutsideClick: false, // Evitar que el usuario cierre el modal al hacer clic fuera de él
                        timerProgressBar:true,
                        didOpen: () => {
                          Swal.showLoading();
                        }
                    });
                    
                    //Crear el Fetch
                    fetch(url, options).then(response => {
                        if (!response.ok) {
                          throw new Error('Error en la respuesta: ' + response.status + ' ' + response.statusText);
                        }
                        console.log(response);
                    })
                    .then(data => {
                      Swal.close(); // Cierra el SweetAlert cuando la operación se complete
                      console.log('data: ', data);
                    })
                    .catch(error => {
                      Swal.close(); // Cierra el SweetAlert si ocurre un error
                      console.error('ERROR en el fetch GARRAFAL: ', error.message);
                      Swal.fire('Error', error.message, 'error'); // Muestra un error en SweetAlert
                    });
                  }
                });
                
                
                //Fin de la funcion printFact()
            }
        },
        computed:{
            calcularTotal(){
                return this.detalles.reduce((acc, detalle) => acc + parseFloat(detalle.cantidad * detalle.precio), 0);
            },
            calcularSaldo(){
                return this.total - this.acuenta;
            },
            incrementDia(){
                let fecEntreg = new Date(new Date().getTime() + this.tiempoDemora * 24 * 60 * 60 * 1000);
                let dia = fecEntreg.getDate();
                let mes = fecEntreg.getMonth() + 1; // Los meses son indexados desde 0, por lo que se suma 1
                let año = fecEntreg.getFullYear();
                
                // Asegurarse de que el día y el mes tengan dos dígitos
                dia = dia < 10 ? '0' + dia : dia;
                mes = mes < 10 ? '0' + mes : mes;
                let fechaString = `${dia}/${mes}/${año}`;
                return fechaString;
            }
        },
        watch:{
            calcularTotal: {
                handler(val){
                    this.total = val.toFixed(2);
                },
                immediate: true
            },
            calcularSaldo: {
                handler(val){
                    this.saldo = val.toFixed(2);
                },
                immediate: true
            },
            incrementDia:{
                handler(val){
                    this.fechaEntrega = val;
                },
                immediate:true
            }
        }
    });
    
  } catch (error) {
    console.error('Error en el fetching data:', error);
  }
})();