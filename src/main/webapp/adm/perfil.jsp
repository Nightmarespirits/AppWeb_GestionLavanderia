<%-- 
    Document   : index
    Created on : 12/04/2024, 06:10:23 PM
    Author     : Tutaya Rivera Clider Fernando
--%>

<%@page import="config.Conexion"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Perfil</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">  
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- JQVMap -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/jqvmap/jqvmap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/daterangepicker/daterangepicker.css">
  <!-- summernote -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/summernote/summernote-bs4.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  
   <!-- DataTables -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
     <style>
        .profile-header {
            text-align: center;
            margin: 20px 0;
        }
        .profile-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
        }
        .profile-info {
            text-align: left;
            margin: 20px;
        }
        .profile-info .row {
            margin-bottom: 10px;
        }
    </style>
    <!-- Incluir Vue.js -->
   <script src="${pageContext.request.contextPath}/plugins/vue/vue.js"></script>
  
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
   <% 
           Conexion cnx = new Conexion();
           Connection cn  = cnx.getCn();
           System.out.println("Estado de conexion" + cn);
   
   %>
             
  <%@include file="jspf/navbar.jspf" %>
  
  <%@include file="jspf/sidebar.jspf" %>
  
  <div class="content-wrapper">
      <div class="container-fluid">
        <input type="hidden" name = "accion" value="INS">
        <div class="card-header">
            <h1 class ="card-title">Perfil de usuario</h1>
            <button type="button" class="close" data-dismiss="card">
                <i class="fa fa-times" aria-hidden="true"></i>
            </button>
         </div>
        <div class="card-body">

            <div class="container">
                <div class="profile-header">
                    <h1>Mi perfil</h1>
                </div>
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="text-center" id="imgMarco">
                                     <img id="fotoEmp" src="../dist/img/default-150x150.png" class="img-thumbnail" width="500px" height="500px">
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="profile-info">
                                    <div class="row">
                                        <div class="col-sm-3"><strong>Nombre:</strong></div>
                                        <div class="col-sm-9" id="empNombres"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-4"><strong>Tipo de Usuario:</strong></div>
                                        <div class="col-sm-8" id="tipoUsr"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3"><strong>Cargo:</strong></div>
                                        <div class="col-sm-9" id="cargo"></div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-sm-5"><strong>Numero de Documento:</strong></div>
                                        <div class="col-sm-7" id="numDoc"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-5"><strong>Nombre de Usuario:</strong></div>
                                        <div class="col-sm-7" id="username"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3"><strong>Contraseña:</strong></div>
                                        <div class="col-sm-9" id="password"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6"><strong>Fecha de Registro:</strong></div>
                                        <div class="col-sm-6" id="fecReg"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="card-footer">
          <button type="button" class="btn btn-primary">Editar Perfil</button>
        </div>
    </div>
      
  </div>
  <%@include file="jspf/footer.jspf" %>
</div>
<!-- ./wrapper -->
<%-- Scripts persolaizado --%>
<script>
//Intentara guardar datos de sesion en el cache sessionStorage
try {
    var user = '<%= request.getAttribute("usrstring") %>';
    let userObj = JSON.parse(user);
    console.log("string" + user);
    console.log("obj" + userObj);
    

    if(  user !== "null" && user !== "{}" && typeof(userObj) === "object"){
        //Guardar datos de session
        window.sessionStorage.setItem('session', user);
    }
    
    if(window.sessionStorage.hasOwnProperty("session")){
        let session = JSON.parse(window.sessionStorage.getItem('session'));

        let nameParsed = session.nombres.split(" ")[0] + " " + session.apellidos.split(" ")[0];
        

        document.getElementById('empNombres').innerHTML= nameParsed;
        document.getElementById('cargo').innerHTML = session.cargo;
       // document.getElementById('imageBitesStr').innerHTML = session.foto;
        document.getElementById('numDoc').innerHTML = session.numDoc;
        document.getElementById('tipoUsr').innerHTML = session.rol;
        document.getElementById('username').innerHTML = session.username;
        document.getElementById('password').innerHTML = session.password;
        document.getElementById('fecReg').innerHTML = session.fecReg;
        
        var fotoEmp =  document.getElementById('fotoEmp');
        // Uint8Array instance
        let bytesArr = new Uint8Array(session.foto);
        let base64BytesArray = bytesToBase64(bytesArr);
        
        fotoEmp.setAttribute("src", "data:image/jpg;base64," + base64BytesArray);    

    }
    
} catch (e) {
    console.log("Error en la renderizacion de datos: " + e);
}
function bytesToBase64(bytes) {
    let binary = '';
    const len = bytes.byteLength;
    for (let i = 0; i < len; i++) {
        binary += String.fromCharCode(bytes[i]);
    }
    return btoa(binary);
}
</script>
<script src="${pageContext.request.contextPath}/js/controller.js"></script>


<!-- jQuery -->
<script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="${pageContext.request.contextPath}/plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 4 -->

<script src="${pageContext.request.contextPath}/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="${pageContext.request.contextPath}/plugins/chart.js/Chart.min.js"></script>
<!-- Sparkline -->
<script src="${pageContext.request.contextPath}/plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="${pageContext.request.contextPath}/plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="${pageContext.request.contextPath}/plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="${pageContext.request.contextPath}/plugins/moment/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="${pageContext.request.contextPath}/plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="${pageContext.request.contextPath}/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${pageContext.request.contextPath}/dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="${pageContext.request.contextPath}/dist/js/pages/dashboard.js"></script>
<!-- DataTables  & Plugins -->
<script src="${pageContext.request.contextPath}/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/jszip/jszip.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/pdfmake/pdfmake.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/pdfmake/vfs_fonts.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>


</body>
</html>
