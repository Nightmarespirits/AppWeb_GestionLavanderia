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
                            <h1>Nuevo Empleado</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <a href="#">Inicio</a>
                                </li>
                                <li class="breadcrumb-item active">
                                     <a href="#">nuevo</a>
                                </li>
                                <li class="breadcrumb-item active">
                                     <a href="#">empleado</a>
                                </li>
                            </ol>
                           
                        </div>
                    </div> 
                </div>
            </section>

            <section class="content">
                <div class="card">
                    <div class="card-header">
                        <h2 class="card-title">Formulario de Registro</h2> 
                         <div class="card-tools">
                            <button type="button" class="btn btn-tools" title="Cerrar" data-card-widget="maximize">
                                <i class="fas fa-expand"></i>
                            </button>
                        </div>
                    </div>
                    
                    <div class="card-body">  
                        
                        <form  class="form-horizontal row" method="post" action="/Web_SistemaLavanderiaControl_SLC/Empleadoslet" enctype="multipart/form-data">
                            <input type="hidden" name="tipoTransac" value="INS">
                            <div class="col-md-8">
                                <!-- Card de registro Empleado-->                                       
                                <div class="card">
                                        <div class="card-header">
                                            <h3 class="card-title">
                                                Datos del Empleado
                                            </h3>

                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    
                                                    <div class="form-group row">
                                                        <label for="Apellidos" class="col-sm-3 col-form-label">Apellidos</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" class="form-control" name="empApellidos" id="empApellidos" placeholder="Apellidos">
                                                        </div>
                                                    </div>  
                                                    <div class="form-group row">
                                                      <label for="Nombres"class="col-sm-3 col-form-label">Nombres</label>
                                                      <div class="col-sm-9">
                                                        <input type="text" class="form-control" name="empNombres" id="empNombres" placeholder="Nombres">

                                                      </div>
                                                    </div>
                                                    <div class="form-group row">
                                                      <label for="Nombres"class="col-sm-3 col-form-label">Genero</label>
                                                      <div class="col-sm-9">
                                                          <select class="form-control select2" name="empGenero" id="empGenero">
                                                              <option>Masculino</option>
                                                              <option selected="selected">Femenino</option>
                                                              <option>Otro</option>
                                                          </select>
                                                        
                                                      </div>
                                                    </div> 
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Tipo de Documento</label>
                                                        <div class="col-sm-8">
                                                            <select class="form-control select2" name="empTipoDoc" id="empTipoDoc" style="width: 100%;">

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
                                                      <label for="empNumDoc"class="col-sm-4 col-form-label">N° Documento</label>
                                                      <div class="col-sm-8">
                                                        <input type="text" class="form-control" name="empNumDoc" id="empNumDoc" placeholder="Numero de Documento">
                                                      </div>
                                                    </div> 
                                                    <div class="form-group row">
                                                      <label for="telef"class="col-sm-3 col-form-label">N° Telef.</label>
                                                      <div class="col-sm-9">
                                                            <input type="text" class="form-control" name="empTelefono" id="empTelefono" placeholder="Telefóno">

                                                      </div>
                                                    </div> 
                                                    <div class="form-group row">
                                                      <label for="email"class="col-sm-3 col-form-label">Email</label>
                                                      <div class="col-sm-9">
                                                        <input type="email" class="form-control" name="empEmail" id="empEmail" placeholder="Email">
                                                      </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Nacionalidad</label>
                                                        <div class="col-sm-8">
                                                            <select class="form-control select2" name="empNacionalidad" id="empNacionalidad" style="width: 100%;">


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
                                                          
                                                    <div class="form-group row">
                                                      <label class="col-sm-4 col-form-label">Fecha de Nacimiento</label>
                                                      <div class="col-sm-8">
                                                        <div class="input-group date" id="reservationdate"  data-target-input="nearest">
                                                             <input type="text" name="empFecNac" id="empFecNac" class="form-control  datepicker-days" data-target="#reservationdate"/>
                                                             <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                                                 <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                             </div>
                                                         </div>
                                                      </div>
                                                    </div>
                                                    <div class="form-group row">
                                                      <label for="fecReg"class="col-sm-5 col-form-label">Fecha de Registro</label>
                                                      <div class="col-sm-7">
                                                          <input type="text" name ="fecReg" id="fecReg" value="" class="form-control disabled" >
                                                      </div>
                                                    </div>              
                                                    
                                                </div>
                                                <div class="col-md-6">
                                                    <!--inicio entrada para la foto-->
                                                    <div class="form-group">
                                                        <img id="previewImg" src="../../dist/img/default-150x150.png" class="img-thumbnail" width="150px" height="150px">
                                                        
                                                        <div class="panel">SUBIR FOTO</div>
                                                        <input type="file" id="nuevaFoto" name="nuevaFoto" accept="image/*" @change="renderImg">

                                                        <p class="help-list-item">Peso màximo 2MB</p>


                                                    </div>

                                                   <!--fin entrada para la foto-->     

                                                   <div class="form-group row">
                                                        <label for="departamento"class="col-sm-4 col-form-label">Departamento:</label>
                                                        <div class="col-sm-8">
                                                            <select class="form-control select2" id="selectDep" name="selectDep" v-model="selectedDepartamento">
                                                                <option value="" disabled>Seleccione un departamento</option>
                                                                <option v-for="(provincias, departamento) in departamentos" :key="departamento" :value="departamento">
                                                                    {{ departamento }}
                                                                </option>
                                                            </select>
                                                        </div>

                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="provincia"class="col-sm-3 col-form-label">Provincia:</label>
                                                        <div class="col-sm-9">
                                                            <select class="form-control select2" id="selectProv" name="selectProv" v-model="selectedProvincia" :disabled="!selectedDepartamento">
                                                                <option value="" disabled>Seleccione una provincia</option>
                                                                <option v-for="(distritos, provincia) in provincias" :key="provincia" :value="provincia">
                                                                    {{ provincia }}
                                                                </option>
                                                            </select>
                                                        </div>

                                                    </div>
                                                     <div class="form-group row">
                                                        <label for="distrito"class="col-sm-3 col-form-label">Distrito:</label>
                                                        <div class="col-sm-9">
                                                            <select class="form-control select2" id="selectDist" name="selectDist" v-model="selectedDistrito" :disabled="!selectedProvincia">
                                                               <option value="" disabled>Seleccione un distrito</option>
                                                               <option v-for="distrito in distritos" :key="distrito" :value="distrito">
                                                                   {{ distrito }}
                                                               </option>
                                                           </select>
                                                        </div>

                                                   </div>
                                                    <div class="form-group row">
                                                      <label for="empDir"class="col-sm-3 col-form-label">Direccion</label>
                                                      <div class="col-sm-9">
                                                        <input type="text" class="form-control" name="empDir" id="empDir" placeholder="Direccion">

                                                      </div>
                                                    </div>
                                                    

                                                    
                                                    <div class="form-group row">
                                                      <label for="empEstCivil"class="col-sm-4 col-form-label">Estado Civil</label>
                                                      <div class="col-sm-8">
                                                          <select class="form-control select2" name="empEstCivil" id="empEstCivil">
                                                              <option>Soltero</option>
                                                              <option>Casado</option>
                                                              <option>Viudo</option>
                                                              <option>Divorciado</option>
                                                          </select>

                                                      </div>
                                                    </div> 
                                                    
                                                    <div class="form-group row">
                                                      <label for="empEstado"class="col-sm-5 col-form-label">Estado Empleado</label>
                                                      <div class="col-sm-7">
                                                        <input type="text" class="form-control" name="empEstado" id="empEstado" placeholder="Estado de empleado">
                                                      </div>
                                                    </div> 
                                                    <div class="form-group row">
                                                      <label for="empNroHijos" class="col-sm-5 col-form-label">Numero de Hijos</label>
                                                      <div class="col-sm-7">
                                                          <input type="text" class="form-control" name="empNroHijos" id="empNroHijos" placeholder="Numero de Hijos">
                                                      </div>
                                                    </div> 
                                                    
                                                </div>
                                            </div>                                                                                               
                                       </div>
                                      </div>   
                            </div>
                            <div class="col-md-4">
                                <!-- Card de registro Contrato-->
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="card-title">
                                            Datos del Contratación
                                        </h3>

                                    </div>
                                    <div class="card-body">                                          
                                        <div class="form-group row">
                                          <label class="col-sm-5 col-form-label">Fecha de Inicio de Contrato</label>
                                          <div class="col-sm-7">
                                              <div class="input-group date" id="fecIncContrato"  data-target-input="nearest">
                                                <input type="text" name="fecIncContrato" id="fecIncContrato" class="form-control  datepicker-days" data-target="#fecIncContrato"/>
                                                <div class="input-group-append" data-target="#fecIncContrato" data-toggle="datetimepicker">
                                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                </div>
                                              </div>
                                          </div>
                                            
                                        </div>
                                        <div class="form-group row">
                                          <label class="col-sm-5 col-form-label">Fecha de Termino de Contrato</label>
                                          <div class="col-sm-7">
                                              <div class="input-group date" id="fecTermContrato"  data-target-input="nearest">
                                                <input type="text" name="fecTermContrato" id="fecTermContrato" class="form-control  datepicker-days" data-target="#fecTermContrato"/>
                                                <div class="input-group-append" data-target="#fecTermContrato" data-toggle="datetimepicker">
                                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                </div>
                                              </div>
                                          </div>
                                            
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-3 col-form-label">Sucursal</label>
                                            <div class="col-sm-9">
                                                <select class="form-control select2" name="empSucursal" id="empSucursal" style="width: 100%;">

                                                <%
                                                try{
                                                  String sql = "select * from tb_Sucursal";
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
                                            <label class="col-sm-5 col-form-label">Cargo</label>
                                            <div class="col-sm-7">
                                                <select class="form-control select2" name="empCargo" id="empCargo" style="width: 100%;">
                                                    <%
                                                    try{
                                                      String sql = "select * from tb_Cargo";
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
                                          <label for="empSueldo" class="col-sm-5 col-form-label">Sueldo</label>
                                          <div class="col-sm-7">
                                               <input type="text" class="form-control" name="empSueldo" id="empSueldo" placeholder="Sueldo empleado">
                                          </div>
                                        </div> 
                                        <div class="form-group row">
                                          <label for="empEstadoContrato" class="col-sm-5 col-form-label">Estado Contrato</label>
                                          <div class="col-sm-7">
                                             <input type="text" class="form-control" name="empEstadoContrato" id="empEstadoContrato" placeholder="Estado del contrato">
                                          </div>
                                        </div>     
                                        <div class="form-group row">
                                          <label for="monedaContrato" class="col-sm-5 col-form-label">Moneda</label>
                                          <div class="col-sm-7">
                                              <select  class="form-control select2" name="monedaContrato" id="monedaContrato">
                                                  <option selected="selected">Soles</option>
                                                  <option selected="selected">Dolares</option>
                                                  <option selected="selected">Euros</option>
                                                  
                                              </select>
                                          </div>
                                        </div> 
                                        <div class="form-group row">
                                          <label for="obsCotrato" class="col-sm-5 col-form-label">Obsevaciones</label>
                                          <div class="col-sm-7">
                                            <input type="text" class="form-control" name="obsCotrato" id="obsCotrato" placeholder="Observaciones">
                                          </div>
                                        </div>
                                        <div class="form-check row">
                                            <input type="checkbox" class="form-check-input" name="checkNuevaCuenta" id="checkNuevaCuenta">
                                            <label class="form-check-label" for="checkNuevaCuenta">Crear Cuenta de Usuario</label>
                                            <br>
                                            <small>Se Enviará correo electronico de confirmación</small>
                                        </div>
                                    </div>
                                  </div>   
                                   <button type="submit" class="btn btn-lg btn-success"> Guardar Datos</button>               
                            </div>
                                             
                        </form>               
                        
                        
                                        
                                        
                    </div>

                    <div class="card-footer">
                        Footer
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
