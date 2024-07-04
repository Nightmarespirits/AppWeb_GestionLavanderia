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
           System.out.println("Estado de conexion" + cn);
   
   %>
             
   <%@include file="../jspf/navbar.jspf" %>
  
  <%@include file="../jspf/sidebar.jspf" %>
  <div id="formRegClientes">

        <div class="content-wrapper">

            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>Nuevo Cliente</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <a href="#">Inicio</a>
                                </li>
                                <li class="breadcrumb-item active">
                                    Nuevo Cliente
                                </li>
                            </ol>
                        </div>
                    </div> 
                </div>
            </section>

            <section class="content">
                <div class="card">
                    <div class="card-header">
                        <h4>Datos del Cliente</h4> 
                    </div>
                    <div class="card-body">
                        <form  class="form-horizontal row" action="/Web_SistemaLavanderiaControl_SLC/ClientesLet" method="post" >
                            <input type="hidden" name="accion" value="INS">
                            <div class="col-md-6">
                              <div class="form-group row">
                                <label for="cliApellidos" class="col-sm-6 col-form-label">Apellidos</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="cliApellidos" name="cliApellidos" placeholder="Apellidos">
                                </div>
                                
                              </div>  
                              <div class="form-group row">
                                <label for="cliNombres" class="col-sm-6 col-form-label">Nombres</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="cliNombres"  name="cliNombres" placeholder="Nombres">
                                </div>
                              </div> 
                              <div class="form-group row">
                                <label for="cliGenero" class="col-sm-6 col-form-label">Genero</label>
                                <div class="col-sm-6">
                                    <select class="form-control select2" name="cliGenero" id="cliGenero">
                                        <option>Masculino</option>
                                        <option>Femenino</option>
                                        <option>Otro</option>
                                        <option>Prefiero No decirlo</option>
                                    </select>
                                </div>
                                
                              </div> 
                              <div class="form-group row">
                                  <label for="selectTipoDoc" class="col-sm-6 col-form-label" >Tipo de Documento</label>
                                  <div class="col-sm-6">
                                     <select class="form-control select2" id="selectTipoDoc" name="selectTipoDoc" style="width: 100%;">

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
                                  
                              </div>
                              <div class="form-group row">
                                <label for="cliNumDoc" class="col-sm-6 col-form-label">Numero de Documento de Identidad</label>
                                <div class="col-sm-6">
                                  <input type="text" class="form-control" id="cliNumDoc"  name="cliNumDoc" placeholder="Numero de Documento">
                                </div>
                              </div> 
                              <div class="form-group row">
                                <label for="cliTelef" class="col-sm-6 col-form-label">Numero Telefonico</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="cliTelef"  name="cliTelef" placeholder="Telefóno">                               
                                </div>
                              </div> 
                              <div class="form-group row">
                                <label for="cliEmail" class="col-sm-6 col-form-label">Correo Electronico</label>
                                <div class="col-sm-6">
                                   <input type="email" class="form-control" id="cliEmail" name="cliEmail" placeholder="Email">
                                </div>
                              </div>
                              <div class="form-group row">
                                  <label for="selectNac" class="col-sm-6 col-form-label" >Nacionalidad</label>
                                  <div class="col-sm-6">
                                      <select class="form-control select2" id="selectNac"  name="selectNac" style="width: 100%;">
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
                                  
                              </div> 
                            </div>
                            <div clas="col-md-6">
                                <div class="form-group row">
                                    <label for="departamento" class="col-sm-6 col-form-label">Departamento:</label>
                                    <div class="col-sm-6">
                                        <select class="form-control select2" id="selectDep" name="selectDep" v-model="selectedDepartamento">
                                            <option value="" disabled>Seleccione un departamento</option>
                                            <option v-for="(provincias, departamento) in departamentos" :key="departamento" :value="departamento">
                                                {{ departamento }}
                                            </option>
                                        </select>
                                    </div>                                 
                                </div>
                                <div class="form-group row">
                                    <label for="provincia" class="col-sm-6 col-form-label">Provincia:</label>
                                    <div class="col-sm-6">
                                        <select class="form-control select2" id="selectProv" name="selectProv" v-model="selectedProvincia" :disabled="!selectedDepartamento">
                                            <option value="" disabled>Seleccione una provincia</option>
                                            <option v-for="(distritos, provincia) in provincias" :key="provincia" :value="provincia">
                                                {{ provincia }}
                                            </option>
                                        </select>
                                    </div>    
                                </div>
                                <div class="form-group row">
                                     <label for="distrito" class="col-sm-6 col-form-label">Distrito:</label>
                                     <div class="col-sm-6">
                                         <select class="form-control select2" id="selectDist" name="selectDist" v-model="selectedDistrito" :disabled="!selectedProvincia">
                                            <option value="" disabled>Seleccione un distrito</option>
                                            <option v-for="distrito in distritos" :key="distrito" :value="distrito">
                                                {{ distrito }}
                                            </option>
                                        </select> 
                                     </div>
                                </div>

                                <div class="form-group row">
                                  <label for="cliDir" class="col-sm-6 col-form-label">Direccion</label>
                                  <div class="col-sm-6">
                                     <input type="text" class="form-control" id="cliDir" name="cliDir" placeholder="Direccion">
                                  </div>
                                </div> 
                                <div class="form-group row">
                                  <label for="cliFecNac" class="col-sm-6 col-form-label">Fecha de Nacimiento</label>
                                  <div class="col-sm-6">
                                      <div class="input-group date" id="reservationdate"  data-target-input="nearest">
                                        <input type="text" class="form-control datetimepicker-input" name="cliFecNac" id="cliFecNac" data-target="#reservationdate"/>
                                        <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                  </div>
                                    
                                </div>
                                <div class="form-group row">
                                  <label for="cliEstCivil" class="col-sm-6 col-form-label">Estado Civil</label>
                                  <div class="col-sm-6">
                                     <input type="text" class="form-control" id="cliEstCivil" name="cliEstCivil" placeholder="Estado Civil">
                                  </div>
                                </div> 
                                <div class="form-group row" >
                                  <label for="cliFecReg" class="col-sm-6 col-form-label">Fecha de Registro</label>
                                  <div class="col-sm-6">
                                      <input type="text"  v-model="fechaActual" name ="cliFecReg"  id="cliFecReg" class="form-control" readonly placeholder="Fecha de registro" >
                                  </div>
                                </div> 
                            </div>
                            
                        </form>
                    </div>

                    <div class="card-footer">
                        <center>
                            <button type="submit" class="btn btn-primary">Guardar Datos</button>
                        </center>
                    </div>

                </div> 
            </section>

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
<script src="../../js/forms.js"></script>
            
</html>
