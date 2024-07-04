//Condicional que controla si el usuario Inicio Sesion o no se ha identificado
if(window.sessionStorage.hasOwnProperty("session")){
    let session = JSON.parse(window.sessionStorage.getItem('session'));

    let nameParsed = session.nombres.split(" ")[0] + " " + session.apellidos.split(" ")[0];
    
    document.getElementById('sessionUsername').innerHTML= nameParsed;
    document.getElementById('usrRol').innerHTML = session.rol;
    
    var fotoUser =  document.getElementById('renderUserImage');
    // Uint8Array instance
    let bytesArr = new Uint8Array(session.foto);
    let base64BytesArray = bytesToBase64(bytesArr);

    fotoUser.setAttribute("src", "data:image/jpg;base64," + base64BytesArray);
}else{
    //(por implementar) Podemos mostrar un modal aqui para que inicie session
    console.log("advertencia: No se inicio Sesion");
}


//Funcion para combertir a BytesBase64
function bytesToBase64(bytes) {
    let binary = '';
    const len = bytes.byteLength;
    for (let i = 0; i < len; i++) {
        binary += String.fromCharCode(bytes[i]);
    }
    return btoa(binary);
}
//Evento para el campo Cerrar session del navbar (Elimina SessionStorage() del cache de navegador)
document.getElementById("cerrarSesion").addEventListener('click', (e) => {
    e.preventDefault();
    if(window.sessionStorage.getItem("session")){
         window.sessionStorage.removeItem("session");
         document.getElementById("cerrarSesion").innerHTML = "Iniciar Sesión";
    }else{
        document.getElementById("cerrarSesion").innerHTML = "Cerrar Sesión";
        console.log("no existe datos de session");
    }
    
    window.location.href = "/Web_SistemaLavanderiaControl_SLC/login.jsp";
    
   
});

/**

//Eventos para la paginacion (llaman al servidor para controlar y manejar la navegacion de usuario
var navlinks = document.querySelectorAll(".navegacion");

navlinks.forEach(function(elem) {
    elem.addEventListener("click", function(e) {
        e.preventDefault(); 
        
        var page = this.getAttribute("id"); 
        
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    document.getElementById("mainContent").innerHTML = xhr.responseText;
                } else {
                    document.getElementById("mainContent").innerHTML = "Error al cargar página";
                }
            }
        };
        
        xhr.open("GET", "/Web_SistemaLavanderiaControl_SLC/sEnrutador?pagina=" + page, true);
        xhr.send();
    });
});

//Eventos subpaginacion (funciona de la misma forma que el anterior
var subnavlinks = document.querySelectorAll(".subnavegacion");
subnavlinks.forEach(function(elem){
    elem.addEventListener('click',function(e){
        e.preventDefault();
        
        var url = this.getAttribute("url");
        var xhr = new XMLHttpRequest();
        xhr.open('GET', url + '?_=' + new Date().getTime(), true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    
                    document.getElementById('mainContent').innerHTML = xhr.responseText;
                    //executeScripts(document.getElementById('mainContent'));
                } else {
                    document.getElementById('mainContent').innerHTML = 'Error al cargar contenido de subnavegacion';
                }
            }
        };
        xhr.send();
    });
});

//Funcion que ejecuta scripts de un elemento incrustado con el evento anterior
function executeScripts(container) {
    const scripts = container.getElementsByTagName('script');
    for (let i = 0; i < scripts.length; i++) {
        const script = scripts[i];
        const newScript = document.createElement('script');
        newScript.text = script.text;
        container.appendChild(newScript).parentNode.removeChild(newScript);
        console.log('llamada a executescripts');
    }
}**/