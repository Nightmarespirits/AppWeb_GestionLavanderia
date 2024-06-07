/* global Swal */

console.log("ckecker: LLAMANDO AL SCRIPT nueva orden ");

document.addEventListener('DOMContentLoaded', (e) => {
    e.preventDefault();
    console.log("checker: cargado documento");
    //Evento keypress o input del Buscador en el sidebar prendas de la nuevaOrden.jsp Aplicacion
    const itemsContainer = document.getElementById('itemsContainer');
    const items = itemsContainer.getElementsByClassName('ul-treeItems');
    var elem = document.getElementById('searchInput');
    console.log("Elemento hallado:" + elem);
    
    document.getElementById('searchInput').addEventListener('input', () => {
        const filter = document.getElementById('searchInput').value.toLowerCase();
 
        for (let i = 0; i < items.length; i++) {
            let item = items[i];
            if (item.textContent.toLowerCase().includes(filter)) {
                item.classList.remove('hidden');
            } else {
                item.classList.add('hidden');
            }
        }

    });
    //Evento click de la tabla de clientes del Buscador de cliente de la app nuevaOrden.jsp
    const clienteFullname = document.getElementById('buscarCliente');
    const cliDocIdentidad = document.getElementById('cliDocIdentidad');
    const clienteEmail = document.getElementById('clienteEmail');
    const clienteDireccion = document.getElementById('clienteDireccion');
    
    document.getElementById('tablaClientes').addEventListener('click',(e) =>{
        console.log("llamada al eventoTbClientes");
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
    });
    
    //Evento Imprimir factura
    document.getElementById('btnImprimirFactura').addEventListener('click', (e) =>{
        console.log('llamada al evento imprimir fatcura correcta');
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
                numero : fila.cells[0].innerText,
                cantidad : fila.cells[2].children[0].value,
                servicio : fila.cells[3].innerText.replace(/\s*\([^)]*\)\s*/, ''),//Formatea: Elimina el contenido entre parentésis
                prenda : fila.cells[4].innerText,
                precio : fila.cells[5].innerText,
                subtotal : fila.cells[6].innerText,
                observaciones : fila.cells[7].children[0].value
                    
            };
            dataOrden.detalles.push(dtl);

        }
        console.log(dataOrden);
        
        const options = {
            method : 'POST',
            headers : {
                'Content-Type': 'application/json' 
            },
            body : JSON.stringify(dataOrden)
        };
        
        fetch(url, options).then(response => {
            if(!response.ok){
                console.log("Error en la respuesta :" + response.toString());
            }else{
                console.log("Respuesta:" + response.toString());
            }
        }).then(data => {
            console.log("exito respuesta: " + data );
            
        }).catch(e => console.log('ERROR GARRAFAL: ' + e));
    });
    
});

const swalWithBootstrapButtons = Swal.mixin({
  customClass: {
    confirmButton: "btn btn-success",
    cancelButton: "btn btn-danger"
  },
  buttonsStyling: false
});
swalWithBootstrapButtons.fire({
  title: "Are you sure?",
  text: "You won't be able to revert this!",
  icon: "warning",
  showCancelButton: true,
  confirmButtonText: "Yes, delete it!",
  cancelButtonText: "No, cancel!",
  reverseButtons: true
}).then((result) => {
  if (result.isConfirmed) {
    swalWithBootstrapButtons.fire({
      title: "Deleted!",
      text: "Your file has been deleted.",
      icon: "success"
    });
  } else if (
    /* Read more about handling dismissals below */
    result.dismiss === Swal.DismissReason.cancel
  ) {
    swalWithBootstrapButtons.fire({
      title: "Cancelled",
      text: "Your imaginary file is safe :)",
      icon: "error"
    });
  }
});


let timerInterval;
Swal.fire({
  title: "Auto close alert!",
  html: "I will close in <b></b> milliseconds.",
  timer: 2000,
  timerProgressBar: true,
  didOpen: () => {
    Swal.showLoading();
    const timer = Swal.getPopup().querySelector("b");
    timerInterval = setInterval(() => {
      timer.textContent = `${Swal.getTimerLeft()}`;
    }, 100);
  },
  willClose: () => {
    clearInterval(timerInterval);
  }
}).then((result) => {
  /* Read more about handling dismissals below */
  if (result.dismiss === Swal.DismissReason.timer) {
    console.log("I was closed by the timer");
  }
});