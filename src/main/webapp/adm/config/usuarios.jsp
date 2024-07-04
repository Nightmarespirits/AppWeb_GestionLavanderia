<%-- 
    Document   : ordenes.jsp
    Created on : 31 may. 2024, 5:24:59 p. m.
    Author     : Clider Fernando Tutaya Rivera 
--%>

<%@page import="Model.Orden"%>
<%@page import="Model.EmpleadoDAO"%>
<%@page import="config.Conexion"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="Model.Usuario"%>
<%@page import="java.util.Base64"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Usuarios</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">  
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="../../plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- Select2 -->
  <link rel="stylesheet" href="../../plugins/select2/css/select2.min.css">
  <link rel="stylesheet" href="../../plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- JQVMap -->
  <link rel="stylesheet" href="../../plugins/jqvmap/jqvmap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="../../plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="../../plugins/daterangepicker/daterangepicker.css">
  <!-- summernote -->
  <link rel="stylesheet" href="../../plugins/summernote/summernote-bs4.min.css">
    <!-- Google Font: Source Sans Pro -->
  
    <!-- DataTables -->
  <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
  
  <link rel="stylesheet" href="../../css/style.css">
  
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Incluir Vue.js -->
   <script src="../../plugins/vue/vue.js"></script>

</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
   <% 
           Conexion cnx = new Conexion();
           Connection cn  = cnx.getCn();
   
   %>
             
  <%@include file="../jspf/navbar.jspf" %>
  
  <%@include file="../jspf/sidebar.jspf" %>
  <div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Administrar Usuarios</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <a href="#">Inicio</a> 
                        </li>
                        <li class="breadcrumb-item active">
                           Administrar Usuarios
                        </li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="card">
            <div class="card-header">
               <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalAgregarUsuario">
                Agregar Usuario
            </button>

                
            </div>
            <div class="card-body">
                <table width="100%" id="example2" class="table-bordered table-striped table table-hover">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Username</th>
                            <th>Empleado</th>
                            <th>Estado</th>
                            <th>Foto</th>
                            <th>Perfil</th>
                            <th>Acciones</th>
                            
                        </tr>
                    </thead>
                        

                    <tbody>
                        <%
                        Usuario usu = new Usuario();
                        List lista = usu.listaUsuario();
                        
                        for(int i=0; i < lista.size();i++){
                            Object fila[] = (Object[]) lista.get(i);
                        
                        %>
                        <tr>
                            <td><%=fila[0]%></td>
                            <td><%=fila[1]%></td>
                            <td><%=fila[2]%></td>
                            <td>
                                <center>
                                <%
                                    int estado = Integer.parseInt(fila[3].toString());
                                    if(estado == 1) {
                                        
                                    
                                %>
                                <button class = "btn btn-success">
                                    Activado
                                </button>
                                <%} 
                                else{
                                %>
                                <button class = "btn btn-danger">
                                    Desactivado
                                </button>
                                
                                <%}%>
                                </center>
                            </td>
                            <td>
                                
                                <center>
                                    <%
                                        String imgString = "";
                                        try {
                                            // Realizamos un casting explícito a byte[]
                                            byte[] imageBytes = (byte[]) fila[4];
                                            imgString = Base64.getEncoder().encodeToString(imageBytes);
                                            System.out.println("Imagen convertida con exito" + imgString);
                                        } catch (ClassCastException e) {
                                            System.out.println("Error al convertir la imagen: " + e.getMessage());
                                        } catch (Exception e) {
                                            System.out.println("Error al decodificar la imagen: " + e.getMessage());
                                        }
                                        
                                    %>
                                    
                                    <img src="data:image/jpeg;base64,<%= imgString %>" width="40px" height="40px" class="img-thumbnail">
                                </center>
                                
                            </td>
                            <td><%=fila[5]%></td>
                            <td>
                                <button class="btn btn-warning" data-toggle="modal" data-target="#modalEditarUsuario">
                                    Editar
                                    <i class="fa fa-edit"></i>
                                </button>
                                
                                
                                    <input type="hidden" id="idusu" name="idusu" value="<%=fila[0]%>">
                                <button class="btn btn-danger" id="btnEliminar">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                        
                        <% } %>
                    </tbody>
                    
                    <tfoot>
                        
                    </tfoot>
                </table>
            </div>
            <div class="card-footer">
                Footer
            </div>
            
        <div class="card">
            
        </div>
    </section>
</div>
<!-- Modal AGREGAR USUARIO-->
<div class="modal fade" id="modalAgregarUsuario" tabindex="-1" role="dialog" aria-labelledby="modalAgregarUsuario" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
        <form method="post" action="/admLTE/sUsuario">
           <div class="modal-header" style="background:#3c8dbc; color:white;">
               <h4 class ="modal-title"> Agregar Usuario</h4>
               <button type="button" class="close" data-dismiss="modal">
                   <i class="fa fa-times" aria-hidden="true"></i>
               </button>
            </div>
            <div class="modal-body">
                <div class="card-body">
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fa fa-users"></i>
                            </span>
                            <input type="text" placeholder="Ingrese el nombre" class="form-control input-lg" name="nuevoNombre" id="nuevoNombre" requerid>
                        </div>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fa fa-superpowers"></i>
                            </span>
                            <input type="text" placeholder="Ingrese Usuario" class="form-control input-lg" name="nuevoUsuario" id="nuevoUsuario" requerid>
                        </div>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fa fa-key"></i>
                            </span>
                            <input type="password" placeholder="Ingrese Contraseña" class="form-control input-lg" name="nuevaContraseña" id="nuevaContraseña" requerid>
                        </div>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fa fa-user"></i>
                            </span>
                            <select class="form-control input-lg" name="nuevoPerfil" id="nuevoPerfil">
                                <option value=""> Seleccionar Perfil </option>
                                <option value="Administrador"> Administrador </option>
                                <option value="Especial"> Especial </option>
                                <option value="Vendedor"> Vendedor </option>
                            </select>
                        </div>
                        <div class="form-group">
                            <div class="panel"> subir foto </div>
                            <input type="file" name="nuevaFoto" id="nuevaFoto">
                            <p class="help-list-item">Peso maximo 2MB</p>
                            <img src="imagenes/OIP.jpg" class="img-thumbnail" width="100px">
                        </div>
                            

                    </div>
                    
                </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Salir</button>
              <button type="submit" class="btn btn-primary"  name="accion" value="INS"> Guardar Cambios </button>
             
            </div>
          
        </form>
    </div> 
  </div>
</div>

<!-- Modal EDITAR USUARIO--->
<div class="modal fade" id="modalEditarUsuario" tabindex="-1" role="dialog" aria-labelledby="modalEditarUsuario" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
        <form action="/admLTE/sUsuario" method="post" rol="form">
            <input type="hidden" name = "accion" value="INS">
           <div class="modal-header" style="background:#3c8dbc; color:white;">
               <h4 class ="modal-title">  Editar Usuario</h4>
               <button type="button" class="close" data-dismiss="modal">
                   <i class="fa fa-times" aria-hidden="true"></i>
               </button>
            </div>
            <div class="modal-body">
                <div class="card-body">
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fa fa-users"></i>
                            </span>
                            <input type="text" placeholder="Ingrese el nombre" class="form-control input-lg" name="nuevoNombre" id="nuevoNombre" requerid>
                        </div>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fa fa-superpowers"></i>
                            </span>
                            <input type="text" placeholder="Ingrese Usuario" class="form-control input-lg" name="nuevoUsuario" id="nuevoUsuario" requerid>
                        </div>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fa fa-key"></i>
                            </span>
                            <input type="password" placeholder="Ingrese Contraseña" class="form-control input-lg" name="nuevaContraseña" id="nuevaContraseña" requerid>
                        </div>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fa fa-user"></i>
                            </span>
                            <select class="form-control input-lg" name="nuevoPerfil" id="nuevoPerfil">
                                <option value=""> Seleccionar Perfil </option>
                                <option value="Administrador"> Administrador </option>
                                <option value="Especial"> Especial </option>
                                <option value="Vendedor"> Vendedor </option>
                            </select>
                        </div>
                        <div class="form-group">
                            <div class="panel"> subir foto </div>
                            <input type="file" name="nuevaFoto">
                            <p class="help-list-item">Peso maximo 2MB</p>
                            <img src="imagenes/OIP.jpg" class="img-thumbnail" width="100px">
                        </div>
                            

                    </div>
                    
                </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Salir</button>
              <button type="button" class="btn btn-primary">Guardar Cambios
              </button>
            </div>
          
        </form>
    </div> 
  </div>
</div>

<!-- Modal ELIMINAR USUARIO--->
<div class="modal fade" id="modalEliminarUsuario" tabindex="-1" role="dialog" aria-labelledby="modalEditarUsuario" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
        <form method="post" action="/admLTE/sUsuario" rol="form">
            <input type="hiden" name="accion" valor="DEL">
           <div class="modal-header" style="background:#3c8dbc; color:white;">
               
               <h4 class ="modal-title">   Eliminar Usuario</h4>
               <button type="button" class="close" data-dismiss="modal">
                   <i class="fa fa-times" aria-hidden="true"></i>
               </button>
            </div>
            <div class="modal-body">
                <div class="card-body">
                    <p>¿Desea Eliminar el Usuario?</p>
                </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrrar</button>
              <button type="submit" class="btn btn-danger" data-dismiss="modal">Eliminar Usuario</button>
            </div>
          
        </form>
    </div> 
  </div>
</div>
  
  
  
  <%@include file="../jspf/footer.jspf" %>
</div>

<script src="../../js/controller.js"></script>

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="../../plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Select2 -->
<script src="../../plugins/select2/js/select2.full.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>

<!-- daterangepicker -->
<script src="../../plugins/moment/moment.min.js"></script>
<script src="../../plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="../../plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="../../plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="../../plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>



<!-- ./wrapper -->
<script src="../../js/registroCliente.js"></script>
            
</html>
