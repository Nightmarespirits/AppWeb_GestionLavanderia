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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Ordenes</title>

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
   <script src="js/app.js"></script>
    
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
      <div class="container-fluid" >
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Ordenes de Servicio</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item">
                                <a href="#">Inicio</a> 
                            </li>
                            <li class="breadcrumb-item active">
                               Administrar
                            </li>
                            <li class="breadcrumb-item ">
                               Ordenes
                            </li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="card">
                <div class="card-header">

                    <button class="btn btn-primary" >Nuevo </button>

                </div>
                <div class="card-body " id="tbosWraper">
                    <table id="tablaOrdenesServicio" class="table-bordered table-hover table-striped table">
                        <thead>
                        <tr>
                          <th>N° Orden</th>
                          <th>Cliente</th>
                          <th>Telefóno</th>
                          <th>Fecha </th>
                          <th>Hora</th>
                          <th>Fecha Entrega </th>
                          <th>Hora Entrega </th>
                          <th>Empleado</th>
                          <th> Acciones </th>

                        </tr>
                        </thead>
                        <tbody>
                        <%
                            try{
                              String sql = "select * from VistaOrdenesServicio";
                              Statement st = cn.createStatement();
                              ResultSet rs = st.executeQuery(sql);
                              while(rs.next()){
                        %>
                                    <tr data-dismiss="modal" >
                                      <td><%=rs.getString(1)%></td>
                                      <td><%=rs.getString(2)%></td>
                                      <td><%=rs.getString(3)%></td>
                                      <td><%=rs.getString(4)%></td>
                                      <td><%=rs.getString(5)%></td>
                                      <td><%=rs.getString(6)%></td>
                                      <td><%=rs.getString(7)%></td>
                                      <td><%=rs.getString(8)%></td>
                                      <td>
                                          <button class="btn btn-warning" data-toogle="modal" data-target="#modalVerDetalles">
                                            Ver Detalles
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-danger">
                                            Imprimir
                                            <i class="fas fa-print text-white" onclick="imprimirFact"></i>
                                        </button>

                                    </td>
                                    </tr>

                        <%      
                              }

                             }catch(Exception e){
                                 System.out.println("Error en listar Clienes - NuevaOrden" + e.getCause());
                             }
                        %>    




                        </tbody>
                        <tfoot>
                        <tr>
                          <th>N° Orden</th>
                          <th>Cliente</th>
                          <th>Telefóno</th>
                          <th>Fecha </th>
                          <th>Hora</th>
                          <th>Fecha Entrega </th>
                          <th>Hora Entrega </th>
                          <th>Empleado</th>
                          <th> Acciones </th>
                        </tr>
                        </tfoot>
                      </table>
                </div>
                <div class="card-footer">
                    Footer
                </div>
            </div>   
        </section>
    </div>
                                
    <div class="modal" id="modalVerDetalles" tabindex="-1"  role="dialog" aria-labelledby="modalVerDetalles" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header" style="background:#3c8dbc; color:white;">
                    <h4 class ="modal-title"> Detalles de Orden </h4>
                    <button type="button" class="close" data-dismiss="modal">
                        <i class="fa fa-times" aria-hidden="true"></i>
                    </button>

                </div>
                <div class="modal-body">
                    <table id="tablaOrdenesServicio" class="table-bordered table-hover table-striped table">
                        <thead>
                        <tr>
                          <th>Servicio</th>
                          <th>Descripcion</th>
                          <th>Precio </th>
                          <th>Cant/Peso</th>
                          <th>SubTotal</th>
                          
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            try{
                              String sql = "select * from VistaOrdenesServicio";
                              Statement st = cn.createStatement();
                              ResultSet rs = st.executeQuery(sql);
                              while(rs.next()){
                        %>
                                    <tr data-dismiss="modal" >
                                      <td><%=rs.getString(1)%></td>
                                      <td><%=rs.getString(2)%></td>
                                      <td><%=rs.getString(3)%></td>
                                      <td><%=rs.getString(4)%></td>
                                    </tr>

                        <%      
                              }

                             }catch(Exception e){
                                 System.out.println("Error en VistaOrdenesServicio" + e.getCause());
                             }
                        %>    




                        </tbody>
                        <tfoot>
                        <tr>
                          <th>Servicio</th>
                          <th>Descripcion</th>
                          <th>Precio </th>
                          <th>Cant/Peso</th>
                          <th>SubTotal</th>
                          
                        </tr>
                        </tfoot>
                      </table>
                    <form>
                        <div class="form-group col">
                            <label for="telefono">Total a Pagar</label>
                            <input type="text"  v-model="total" class="form-control" id="total" readonly>
                        </div>  
                        <div class="form-group col">
                            <label for="telefono">A Cuenta:</label>
                            <input type="text" v-model="acuenta" class="form-control" id="aCuenta">

                        </div>  
                        <div class="form-group col">
                            <label for="telefono">Saldo: </label>
                            <input type="text" v-model="saldo" class="form-control" id="saldo" readonly>
                        </div> 
                    </form>

                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Salir</button>
                </div>
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
      
    $("#tablaClientes").DataTable({
      "responsive": true, "lengthChange": false, "autoWidth": false
    });
    $("#tablaOrdenesServicio").DataTable({
      "responsive": true, "lengthChange": false, "autoWidth": false,
      "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
    }).buttons().container().appendTo('#tbosWraper .col-md-6:eq(0)');
    
    
    
  });
</script>


</body>
</html>
