<%-- 
    Document   : ordenes.jsp
    Created on : 31 may. 2024, 5:24:59 p. m.
    Author     : Clider Fernando Tutaya Rivera 
--%>

<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="config.Conexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.Orden"%>
<%@page import="Model.Cliente"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Clientes</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">  
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- JQVMap -->
  <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
  <!-- summernote -->
  <link rel="stylesheet" href="plugins/summernote/summernote-bs4.min.css">
  
    <!-- DataTables -->
  <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
  
  <link rel="stylesheet" href="css/style.css">
  
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Incluir Vue.js -->
   <script src="plugins/vue/vue.js"></script>
   <!-- Script de la Aplicación Vue.js -->
   <script src="js/utils.js"></script>
    
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
  <div>

        <%
        int id=0;

        %>
        <div class="content-wrapper">

            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>Administrar Clientes</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <a href="#">Inicio</a>
                                </li>
                                <li class="breadcrumb-item active">
                                    Administrar Clientes
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
                        <button type="button" class="btn btn-primary" 
                                data-toggle="modal" 
                                data-target="#modalAgregarCliente">
                          Agregar Cliente
                        </button>
                    </div>

                    <div class="card-body">
                        <table id="example2" class="table-bordered table table-striped table-hover" 
                               width="100%">
                            <thead>
                                <tr>
                                    <th>Id</th>
                                    <th>Nombres</th>
                                    <th>Apellidos</th>
                                    <th>Genero</th>
                                    <th>Tipo Doc</th>
                                    <th>N° Doc</th>
                                    <th>Telefono</th>
                                    <th>Email</th>
                                    <th>Distrito</th>
                                    <th>Nacionalidad</th>
                                    <th>Direccion</th>
                                    <th>Fec Nacimiento</th>
                                    <th>Fec Registro</th>
                                    <th>E Civil</th>
                                    <th>Foto</th>
                                    <th>Acciones</th>
                                </tr> 
                            </thead>

                            <tbody>
                                <%
                                Cliente cli= new Cliente();
                                List listaClientes= cli.listarClientes();

                                for(int i=0;i<listaClientes.size();i++){
                                    Object fila[]=(Object[])listaClientes.get(i);
                                    id=Integer.parseInt(fila[0].toString());

                                %>

                                <tr>
                                    <td><%=fila[0]%></td>
                                    <td><%=fila[1]%></td>
                                    <td><%=fila[2]%></td>
                                    <td><%=fila[3]%></td>
                                    <td><%=fila[4]%></td>
                                    <td><%=fila[5]%></td>
                                    <td><%=fila[6]%></td>
                                    <td><%=fila[7]%></td>
                                    <td><%=fila[8]%></td>
                                    <td><%=fila[9]%></td>
                                    <td><%=fila[10]%></td>
                                    <td><%=fila[11]%></td>
                                    <td><%=fila[12]%></td>
                                    <td><%=fila[13]%></td>
                                    <td><%=fila[14]%></td>
                                    <td>
                                        <button class="btn btn-warning"
                                                data-toggle="modal"
                                                data-target="#modalEditarCliente">
                                            <i class="fas fa-edit text-white" ></i>
                                        </button>


                                        <input type="hidden" id="idusu" name="idusu" 
                                                  value="<%=fila[0]%>">

                                         <button class="btn btn-danger"
                                                 id="btnEliminar">
                                            <i class="fa fa-trash" ></i>
                                         </button>   
                                    </td>
                                </tr>

                                <%
                                  }
                                %>

                            </tbody>
                        </table>
                    </div>

                    <div class="card-footer">
                        Footer
                    </div>

                </div> 
            </section>

        </div>


        <!-- Modal Agregar usuario-->
        <div class="modal fade" id="modalAgregarCliente" tabindex="-1" role="dialog" aria-labelledby="modalAgregarCliente" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form  action="/Web_SistemaLavanderiaControl_SLC/ClientesLet" method="post" >
                    <input type="hidden" name="accion" value="INS">

                    <div class="modal-header" 
                         style="background:#3c8dbc;color: white">

                        <h4 class="modal-title">Agregar Nuevo Cliente</h4>

                        <button type="button" class="close" 
                                data-dismiss="modal">
                            &times;
                        </button>

                    </div>

                    <div class="modal-body">      
                        <div class="card-body">
                            <div class="form-group">
                              <label for="cliApellidos">Apellidos</label>
                              <input type="text" class="form-control" id="cliApellidos" name="cliApellidos" placeholder="Apellidos">
                            </div>  
                            <div class="form-group">
                              <label for="cliNombres">Nombres</label>
                              <input type="text" class="form-control" id="cliNombres" name="cliNombres" placeholder="Nombres">
                            </div> 
                            <div class="form-group">
                                <label>Tipo de Documento</label>
                                <select class="form-control select2" id="selectTipoDoc" style="width: 100%;">

                                    <%
                                    try{
                                      String sql = "select * from tb_TipoDoc";
                                      Statement st = cn.createStatement();
                                      ResultSet rs = st.executeQuery(sql);
                                      while(rs.next()){



                                    %>
                                      <option><%=rs.getString(2)%></option>
                                      <%
                                         }

                                      }catch(Exception e){
                                          System.out.println(e.getCause());
                                      }
                                      %>
                                </select>
                            </div>
                            <div class="form-group">
                              <label for="nroDoc">Numero de Documento de Identidad</label>
                              <input type="text" class="form-control" id="cliNroDoc" placeholder="Numero de Documento">
                            </div> 
                            <div class="form-group">
                              <label for="telef">Numero Telefonico</label>
                              <input type="text" class="form-control" id="cliTelef" placeholder="Telefóno">
                            </div> 
                            <div class="form-group">
                              <label for="email">Correo Electronico</label>
                              <input type="email" class="form-control" id="cliEmail" placeholder="Email">
                            </div>
                            <div class="form-group">
                                <label>Nacionalidad</label>
                                <select class="form-control select2" id="selectNac" style="width: 100%;">


                                    <option selected="selected">Peruana</option>
                                      <% 
                                      try{
                                          String sql = "select * from tb_Nacionalidad";
                                          Statement st = cn.createStatement();
                                          ResultSet rs = st.executeQuery(sql);
                                          while(rs.next()){
                                      %>
                                    <option><%=rs.getString(3)%></option>

                                      <%
                                           }

                                        }catch(Exception e){
                                            System.out.println(e.getCause());
                                        }     

                                      %>

                                </select>
                            </div>
                            <div class="form-group">
                              <label>Departamento</label>
                              <select class="form-control select2" id="selectDep" name="selectDep" style="width: 100%;" onchange="listarProv()">
                                  <option selected="selected" value="Lima">Lima</option>
                                  <% try {
                                      String sql = "select * from tb_Departamento";
                                      Statement st = cn.createStatement();
                                      ResultSet rs = st.executeQuery(sql);
                                      while (rs.next()) { %>
                                          <option><%= rs.getString(2) %></option>
                                      <% }
                                      rs.close();
                                      st.close();
                                  } catch (Exception e) {
                                      System.out.println(e.getMessage());
                                  } %>
                              </select>
                           </div>
                            <div class="form-group">
                                <label>Provincia</label>
                                <select class="form-control select2" id="selectProv" name="selectProv" style="width: 100%;" onchange="listarDist()">
                                    <option selected="selected">Lima</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Distrito</label>
                                <select class="form-control select2" id="selectDist" name="selectDist" style="width: 100%;">
                                    <option selected="selected">Lima</option>
                                </select>
                            </div>
                            <div class="form-group">
                              <label for="cliDireccion">Direccion</label>
                              <input type="text" class="form-control" id="cliDireccion" placeholder="Direccion">
                            </div> 
                            <div class="form-group">
                              <label>Fecha de Nacimiento</label>
                                <div class="input-group date" id="reservationdate"  data-target-input="nearest">
                                    <input type="text" class="form-control datetimepicker-input" name="cliFecNac" data-target="#reservationdate"/>
                                    <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                              <label for="cliEstCivil">Estado Civil</label>
                              <input type="text" class="form-control" id="cliEstCivil" placeholder="Estado Civil">
                            </div> 
                            <div class="form-group" >
                              <label for="fecReg">Fecha de Registro</label>
                              <input type="text" name ="cliFecReg"  id="cliFecReg" class="form-control disabled" placeholder="Fecha de registro">
                            </div> 
                            <!--inicio entrada para la foto-->
                            <div class="form-group">
                                <div class="panel">SUBIR FOTO</div>
                                <input type="file" 
                                       name="nuevaFoto">

                                <p class="help-list-item">Peso màximo 2MB</p>
                                <img src="imagenes/default.jpg" 
                                     class="img-thumbnail"
                                     width="100px">

                            </div>

                           <!--fin entrada para la foto--> 
  
                        </div>
                        <div class="card-footer ">
                            <center>
                                <button type="submit" class="btn btn-primary">Guardar Datos</button>
                            </center>
                        </div> 
                    </div>


                    <div class="modal-footer">
                        <button type="button"
                                class="btn btn-default pull-left" 
                                data-dismiss="modal">
                            Salir
                        </button>
                         <button type="submit"
                                 class="btn btn-primary"
                                 >
                             Guardar Usuario
                         </button>  

                    </div>
                </form>
            </div>
          </div>
        </div>



        <!-- Modal Editar Cliente-->
        <div class="modal fade" id="modelEditarCliente" tabindex="-1" role="dialog" aria-labelledby="modelEditarCliente" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form rol="form" action="" method="post" 
                      enctype="multipart/form-data">

                    <div class="modal-header" 
                         style="background:#3c8dbc;color: white">

                        <h4 class="modal-title">Editar Registro de Cliente</h4>

                        <button type="button" class="close" 
                                data-dismiss="modal">
                            &times;
                        </button>

                    </div>

                    <div class="modal-body">
                        <div class="card-body">
                            <div class="form-group">
                              <label for="Apellidos">Apellidos</label>
                              <input type="text" class="form-control" id="cliApellidos" placeholder="Apellidos">
                            </div>  
                            <div class="form-group">
                              <label for="cliNombres">Nombres</label>
                              <input type="text" class="form-control" name="cliNombres" id="cliNombres" placeholder="Nombres">
                            </div> 
                            <div class="form-group">
                                <label>Tipo de Documento</label>
                                <select class="form-control select2" id="selectTipoDoc" style="width: 100%;">

                                    <%
                                    try{
                                      String sql = "select * from tb_TipoDoc";
                                      Statement st = cn.createStatement();
                                      ResultSet rs = st.executeQuery(sql);
                                      while(rs.next()){



                                    %>
                                      <option><%=rs.getString(2)%></option>
                                      <%
                                         }

                                      }catch(Exception e){
                                          System.out.println(e.getCause());
                                      }
                                      %>
                                </select>
                            </div>
                            <div class="form-group">
                              <label for="nroDoc">Numero de Documento de Identidad</label>
                              <input type="text" class="form-control" id="cliNroDoc" placeholder="Numero de Documento">
                            </div> 
                            <div class="form-group">
                              <label for="telef">Numero Telefonico</label>
                              <input type="text" class="form-control" id="cliTelef" placeholder="Telefóno">
                            </div> 
                            <div class="form-group">
                              <label for="email">Correo Electronico</label>
                              <input type="email" class="form-control" id="cliEmail" placeholder="Email">
                            </div>
                            <div class="form-group">
                                <label>Nacionalidad</label>
                                <select class="form-control select2" id="selectNac" style="width: 100%;">


                                    <option selected="selected">Peruana</option>
                                      <% 
                                      try{
                                          String sql = "select * from tb_Nacionalidad";
                                          Statement st = cn.createStatement();
                                          ResultSet rs = st.executeQuery(sql);
                                          while(rs.next()){
                                      %>
                                    <option><%=rs.getString(3)%></option>

                                      <%
                                           }

                                        }catch(Exception e){
                                            System.out.println(e.getCause());
                                        }     

                                      %>

                                </select>
                            </div>
                            <div class="form-group">
                              <label>Departamento</label>
                              <select class="form-control select2" id="selectDep" name="selectDep" style="width: 100%;" onchange="listarProv()">
                                  <option selected="selected" value="Lima">Lima</option>
                                  <% try {
                                      String sql = "select * from tb_Departamento";
                                      Statement st = cn.createStatement();
                                      ResultSet rs = st.executeQuery(sql);
                                      while (rs.next()) { %>
                                          <option><%= rs.getString(2) %></option>
                                      <% }
                                      rs.close();
                                      st.close();
                                  } catch (Exception e) {
                                      System.out.println(e.getMessage());
                                  } %>
                              </select>
                           </div>
                            <div class="form-group">
                                <label>Provincia</label>
                                <select class="form-control select2" id="selectProv" name="selectProv" style="width: 100%;" onchange="listarDist()">
                                    <option selected="selected">Lima</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Distrito</label>
                                <select class="form-control select2" id="selectDist" name="selectDist" style="width: 100%;">
                                    <option selected="selected">Lima</option>
                                </select>
                            </div>
                            <div class="form-group">
                              <label for="cliDireccion">Direccion</label>
                              <input type="text" class="form-control" id="cliDireccion" placeholder="Direccion">
                            </div> 
                            <div class="form-group">
                              <label>Fecha de Nacimiento</label>
                                <div class="input-group date" id="reservationdate"  data-target-input="nearest">
                                    <input type="text" class="form-control datetimepicker-input" name="cliFecNac" data-target="#reservationdate"/>
                                    <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                              <label for="cliEstCivil">Estado Civil</label>
                              <input type="text" class="form-control" id="cliEstCivil" placeholder="Estado Civil">
                            </div> 
                            <div class="form-group" >
                              <label for="fecReg">Fecha de Registro</label>
                              <input type="text" name ="cliFecReg"  id="cliFecReg" class="form-control disabled" placeholder="Fecha de registro">
                            </div> 
                            <!--inicio entrada para la foto-->
                            <div class="form-group">
                                <div class="panel">SUBIR FOTO</div>
                                <input type="file" 
                                       name="nuevaFoto">

                                <p class="help-list-item">Peso màximo 2MB</p>
                                <img src="imagenes/default.jpg" 
                                     class="img-thumbnail"
                                     width="100px">

                            </div>

                           <!--fin entrada para la foto-->
                            
                            
                            
                        </div>

                    </div>


                    <div class="modal-footer">
                        <button type="button"
                                class="btn btn-default pull-left" 
                                data-dismiss="modal">
                            Salir
                        </button>
                         <button type="submit"
                                 class="btn btn-primary" 
                                 data-dismiss="modal">
                            Guardar Usuario
                        </button>
                    </div>
                </form>
            </div>
          </div>
        </div>                
  </div>
  
  
  
  <%@include file="jspf/footer.jspf" %>
</div>
<!-- ./wrapper -->
<script src="js/controller.js"></script>
<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>

<!-- daterangepicker -->
<script src="plugins/moment/moment.min.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>


<!-- DataTables  & Plugins -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="plugins/jszip/jszip.min.js"></script>
<script src="plugins/pdfmake/pdfmake.min.js"></script>
<script src="plugins/pdfmake/vfs_fonts.js"></script>
<script src="plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>

<script>
  $(function () {
    $("#example1").DataTable({
      "responsive": true, "lengthChange": false, "autoWidth": false,
      "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
    }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
    
        $('#example2').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false,
      "responsive": true
  
    }
            
    );
  });
</script>


</body>
</html>