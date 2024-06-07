<%-- 
    Document   : index
    Created on : 12/04/2024, 06:10:23 PM
    Author     : Tutaya Rivera Clider Fernando
--%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="config.Conexion"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Lavanderia Control</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">  
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="../../plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
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
  <link rel="stylesheet" href="../../css/style.css">
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
             
   <%@include file="../../jspf/navbar.jspf" %>
  
   <%@include file="../../jspf/sidebar.jspf" %>
  
   <!-- Aplicacion Vue js Script -->
<script>
    console.log("señales de vida");
/*Variables para usar en la aplicacion Vue*/
var fechaActual = new Date();

// Obtener los componentes de la fecha actual
var dia = fechaActual.getDate();
var mes = fechaActual.getMonth() + 1; // ¡Recuerda que los meses se indexan desde 0!
var anio = fechaActual.getFullYear();

// Obtener los componentes de la hora actual
var hora = fechaActual.getHours();
var minutos = fechaActual.getMinutes();
var segundos = fechaActual.getSeconds();

// Formatear la fecha y hora actual como texto
var fechaFormateada = anio + '-' + (mes < 10 ? '0' : '') + mes + '-' + (dia < 10 ? '0' : '') + dia;
var horaFormateada = (hora < 10 ? '0' : '') + hora + ':' + (minutos < 10 ? '0' : '') + minutos + ':' + (segundos < 10 ? '0' : '') + segundos;




/*Creacion del template Vue*/
   new Vue({
       el: '#aplicacion',
       data(){
           return{
               
               username:'Tutaya Rivera',
               fecha:fechaFormateada,
               hora: horaFormateada,
               subTotal : '',
               detalles:[]
           };
       },
       methods:{
           agregarDetalle(prenda){
               parsed = prenda.target.textContent.trim();
               console.log('este es el valo de prenda' + parsed);
               var prendDetal = parsed.split('S/.');
               this.detalles.push({
                   prenda: prendDetal[0],
                   precio: prendDetal[1],
                   tipoServ: document.getElementById('tipoServ').value
               });
               console.log(detalles[0]);
           },
           delDetalle(index){
               this.detalles.splice(index,1);
           }
           
       }
       
   });
   
   
   
</script>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" id="mainContent">
        <!--/App OrdenServicios-->
       <div class="card container-fluid" id="aplicacion">
            <div class="card-header ordenHeader">
              <div class="row">
                <div class="col-sm-6">
                    <h3> Nueva Orden de Servicio </h3>
                </div>
                <div class="col-sm-5">

                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="#">Home</a> 
                        </li>
                        <li class="breadcrumb-item">

                            <a href="#">Nuevo</a> 
                        </li>
                        <li class="breadcrumb-item active">
                            <a href="#">Orden</a> 
                        </li>
                    </ol>

                </div>
                <div class="card-tools col-sm-1 divflex">
                    <button type="button" class="btn btn-tool" data-card-widget="maximize">
                        <i class="fas fa-expand" style="width: 20px; height: 20px;"></i>
                    </button>
                </div>
              <!-- /.card-tools -->
              </div>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <div class="row">
              <!-- Columna del formulario -->
              <div class="col-md-9">
                <!-- Card Fromulario Detalle Servicios-->  
                <div class="card shadow-lg tarjetaSombreada">
                    <div class="card-header">
                        <h5 class="card-title">Detalle Servicio</h5>
                    </div>

                    <form class="form-inline formularioDetalleSrvicio">
                      <div class="form-row">
                        <div class="form-group col-lg-4">
                           <label for="nroOrden" >NRO:</label>
                           <input type="text" class="form-control " id="nroOrden" name="nroOrden" placeholder="Numero de Orden">
                        </div>
                        <div class="form-group col-lg-4">
                            <label>Delivery:</label><br>
                            <div class="form-check form-check-inline">
                              <input class="form-check-input" type="radio" name="delivery" id="delivery_si" value="si">
                              <label class="form-check-label" for="delivery_si">Sí</label>
                            </div>
                            <div class="form-check form-check-inline">
                              <input class="form-check-input" type="radio" name="delivery" id="delivery_no" value="no">
                              <label class="form-check-label" for="delivery_no">No</label>
                            </div>
                        </div>
                        <div class="form-group col-lg-4">
                          <label>Fecha:</label>
                            <div class="input-group date" id="reservationdate" data-target-input="nearest">
                                <input type="text" class="form-control datetimepicker-input" data-target="#reservationdate" name="fechaDelivery" id="fechaDelivery"/>
                                <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                        </div>
                      </div>
                    <div class="form-row">
                        <div class="form-group frmg">
                            <label for="inputCliente">Cliente:</label>
                            <div class="input-group gcliente">
                              <input type="text" class="form-control" id="buscarCliente" name="buscarCliente" placeholder="Buscar cliente" data-toggle="modal" data-target="#modalBuscarCliente" aria-describedby="btnAgregarCliente">
                              <div class="input-group-append align-rigth">
                                <button class="btn btn-outline-secondary" type="button" id="btnAgregarCliente" data-toggle="modal" data-target="#modalAgregarCliente">Agregar Cliente</button>
                              </div>
                            </div>
                         </div>
                    </div>  

                       <div class="form-row">
                           <div class="form-group col-4">
                            <label for="telefono">Telefono: </label>
                            <input type="text" class="form-control" id="telefono" placeholder="Numero Telefonico">
                           </div>
                           <div class="form-group col-4">
                            <label for="email">Email: </label>
                            <input type="email" class="form-control" id="email" placeholder="Correo Electronico">
                           </div>
                           <div class="form-group col-4">
                            <label for="direccion">Direccion: </label>
                            <input type="text" class="form-control" id="direccion" placeholder="Dirección">
                           </div>
                       </div>

                      <div class="form-row">
                        <div class="form-group col-6">
                          <label>Fecha de Recepción:</label>

                          <div class="input-group">
                            <div class="input-group-prepend">
                              <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                            </div>
                            <input type="text" v-model="fecha" class="form-control" data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy" data-mask>
                          </div>
                          <!-- /.input group -->
                        </div>
                        <div class="form-group col-6">
                          <label>Fecha de Entrega:</label>

                          <div class="input-group">
                            <div class="input-group-prepend">
                              <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                            </div>
                            <input type="text" class="form-control"  data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy" data-mask>
                          </div>
                          <!-- /.input group -->
                        </div>
                      </div>
                      <div class="form-row">
                          <div class="form-group col-7">
                            <label for="inputEmp">Empleado:</label>
                            <div class="input-group empInpt">
                              <input type="text" class="form-control" v-model="username" id="inputCliente" readonly placeholder="Nombre Empleado">
                            </div>
                          </div>
                          <div class="form-group col-5">
                            <label for="inputEmp">Hora De Entrega:</label>
                            <div class="input-group horaentInpt">
                              <input type="text" v-model="hora" class="form-control" id="inputCliente"  placeholder="">
                            </div>
                          </div>

                      </div>    
                    </form>

                        <!-- Card Table Detalle Servicios-->
                    <div class="card">
                        <div class="card-body table-responsive p-0" style="height: 150px;">
                          <table class="table table-head-fixed text-nowrap" class="table-hover">
                            <thead>
                              <tr>
                                <th>#</th>
                                <th>Item</th>
                                <th>Cant</th>
                                <th>Servicio</th>
                                <th>Prenda</th>
                                <th>Precio</th>
                                <th>Subtotal</th>
                                <th>Observaciones</th>
                              </tr>
                            </thead>
                            <tbody>
                              <tr v-for="(detalle, index) in detalles" :key="index">
                                <td> 
                                    <span @click='delDetalle(index)'>
                                       <i class='fas fa-trash' ></i>
                                    </span>

                                </td>
                                <td>
                                   <span>
                                       {{index +1}}
                                   </span>
                                </td>
                                <td><input v-model="subTotal" class='tbDetailsCantInpt'></td>
                                <td>{{detalle.tipoServ}}</td>
                                <td>{{detalle.prenda}}</td>
                                <td>{{detalle.precio}}</td>
                                <td>{{subTotal * detalle.precio}}</td>
                                <td><input type='text'></input></td>
                              </tr>
                            </tbody>
                          </table>
                        </div>
                        <!-- /.card-body -->
                        <!-- /.Card Formulario Detalle Servicios -->
                    </div>
                    <!-- /.card Table Detalle Servicios -->


                <!-- botones del footer del card principal detalle servicios -->  
                <div class="card-footer">
                    <div class='form-row'> 
                        <div class="form-group col-4">
                            <button class='btn btn-success'> Agregar Pago</button>
                        </div> 
                        <div class="form-group col-2">
                            <label for="telefono">Recargo</label>
                            <input type="text" class="form-control" id="telefono" placeholder="Numero Telefonico">
                        </div>  
                        <div class="form-group col-2">
                            <label for="telefono">Total: </label>
                            <input type="text" class="form-control" id="telefono" placeholder="Numero Telefonico">
                        </div>

                        <div class='form-group col-4'>
                            <button class="btn btn-success"> Imprimir </button>
                        </div>

                    </div>


                </div>
                <!-- /botones del footer del card principal detalle servicios -->  
                </div>
              </div>

              <!-- Columna de la tabla acordeon Buscar Servicios -->
              <div class="col-md-3">
                <div class="card">
                      <div class="card-header">
                        <h3 class="card-title">Prendas</h3>
                      </div>
                      <!-- ./card-header -->
                      <div class="card-body p-0">
                         <div class="m-3">
                          <!-- SidebarSearch Form -->
                          <div class="form-inline">
                            <div class="input-group" data-widget="sidebar-search">
                              <input class="form-control form-control-sidebar" type="search" placeholder="Buscar Servicio" aria-label="Search">
                              <div class="input-group-append">
                                <button class="btn btn-sidebar">
                                  <i class="fas fa-search fa-fw"></i>
                                </button>
                              </div>
                            </div>
                          </div>   
                         </div>

                         <div class="m-3">
                             <div class="form-group">
                                <label>Tipo de Servicio</label>
                                <select class="form-control select2" name="tipoServ" id="tipoServ" style="width: 100%;">
                                  <option>{{tipoServicios[0]}}</option>
                                </select>
                            </div>  
                         </div>


                        <table class="table table-hover tabla-prendas">
                          <tbody>

                            <tr data-widget="expandable-table" aria-expanded="true">
                              <td>
                                <i class="expandable-table-caret fas fa-caret-right fa-fw"></i>
                                somevalues
                              </td>
                            </tr>

                            <tr class="expandable-body">
                              <td>
                                <div class="p-0">
                                  <table class="table table-hover">
                                    <tbody>
                                      <tr>
                                          <td @click="agregarDetalle"  >

                                          </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </div>
                              </td>
                            </tr>
                          </tbody>
                        </table>      
                      </div>
                      <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
              </div>
              <!--/.Columna de la tabla acordeon Buscar Servicios -->
              </div>
            </div>
            <!-- /.card-body -->
                    <!--MODAL Buscar Cliente-->   
        <div class="modal fade" id="modalBuscarCliente" tabindex="-1" role="dialog" aria-labelledby="modalBuscarCliente" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">


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
                                        <i class="fa fa-search"></i>
                                    </span>
                                    <input type="text" placeholder="Buscar por nombre, apellido, DNI" class="form-control input-lg" name="busquedaCliente" id="busquedaCliente" requerid>
                                </div>
                            </div>

                        </div>
                    </div>



            </div> 
          </div>
        </div>
        <!--/MODAL Buscar Cliente-------------->   

        <!----MODAL AGREGAR EMPLEADO---->  
        <div class="modal fade" id="modalAgregarCliente" tabindex="-1" role="dialog" aria-labelledby="modalAgregarCliente" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <form method="post" action="/SistemaAtencionCliente_LavanderiaWashSpeed/server" enctype="multipart/form-data">
                        <input type="hidden" name="tipoTransac" value="INS">
                       <div class="modal-header" style="background:#3c8dbc; color:white;">
                           <h4 class ="modal-title"> Agregar Empleado</h4>
                           <button type="button" class="close" data-dismiss="modal">
                               <i class="fa fa-times" aria-hidden="true"></i>
                           </button>
                        </div>
                        <div class="modal-body">
                          <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">
                                    Formulario de Registro
                                </h3>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tools" title="Cerrar" data-card-widget="maximize">
                                        <i class="fas fa-expand"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                  <label for="Apellidos">Apellidos</label>
                                  <input type="text" class="form-control" name="empApellidos" id="empApellidos" placeholder="Apellidos">
                                </div>  
                                <div class="form-group">
                                  <label for="Nombres">Nombres</label>
                                  <input type="text" class="form-control" name="empNombres" id="empNombres" placeholder="Nombres">
                                </div>
                                <div class="form-group">
                                  <label for="Nombres">Genero</label>
                                  <input type="text" class="form-control" name="empGenero" id="empGenero" placeholder="Nombres">
                                </div> 
                                <div class="form-group">
                                    <label>Tipo de Documento</label>
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
                                <div class="form-group">
                                  <label for="empNumDoc">Numero de Documento de Identidad</label>
                                  <input type="text" class="form-control" name="empNumDoc" id="empNumDoc" placeholder="Numero de Documento">
                                </div> 
                                <div class="form-group">
                                  <label for="telef">Numeo Telefonico</label>
                                  <input type="text" class="form-control" name="empTelefono" id="empTelefono" placeholder="Telefóno">
                                </div> 
                                <div class="form-group">
                                  <label for="email">Correo Electronico</label>
                                  <input type="email" class="form-control" name="empEmail" id="empEmail" placeholder="Email">
                                </div>
                                <div class="form-group">
                                    <label>Nacionalidad</label>
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
                                    <select class="form-control select2" id="empDist" name="empDist" style="width: 100%;">
                                        <option selected="selected">Lima</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                  <label for="empDir">Direccion</label>
                                  <input type="text" class="form-control" name="empDir" id="empDir" placeholder="Direccion">
                                </div> 
                                <div class="form-group">
                                  <label>Fecha de Nacimiento</label>
                                    <div class="input-group date" id="reservationdate"  data-target-input="nearest">
                                        <input type="text" name="empFecNac" id="empFecNac" class="form-control  datepicker-days" data-target="#reservationdate"/>
                                        <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                  <label for="empEstCivil">Estado Civil</label>
                                  <input type="text" class="form-control" name="empEstCivil" id="empEstCivil" placeholder="Estado Civil">
                                </div> 
                                <div class="form-group">
                                    <label>Sucursal</label>
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
                                <div class="form-group">
                                  <label for="empEstado">Estado Empleado</label>
                                  <input type="text" class="form-control" name="empEstado" id="empEstado" placeholder="Estado de empleado">
                                </div> 
                                <div class="form-group">
                                  <label for="empNroHijos">Numero de Hijos</label>
                                  <input type="text" class="form-control" name="empNroHijos" id="empNroHijos" placeholder="Numero de Hijos">
                                </div> 
                                <div class="form-group">
                                  <label for="fecReg">Fecha de Registro</label>
                                  <input type="text" name ="fecReg" id="fecReg" value="" class="form-control disabled" >
                                </div> 

                                <div class="form-group">
                                  <label for="empFoto">Foto Empleado</label>
                                  <div class="input-group">
                                    <div class="custom-file">
                                      <input type="file" class="custom-file-input" name="empFoto" id="empFoto">
                                      <label class="custom-file-label" for="exampleInputFile">Choose file</label>
                                    </div>
                                    <div class="input-group-append">
                                      <span class="input-group-text">Subir Archivo</span>
                                    </div>
                                  </div>
                                </div>

                                <div class="form-check">
                                  <input type="checkbox" class="form-check-input" name="checkNuevaCuenta" id="checkNuevaCuenta">
                                  <label class="form-check-label" for="checkNuevaCuenta">Crear Cuenta de Usuario</label>
                                  <br>
                                  <small>Se Enviará correo electronico de confirmación</small>
                                </div>
                            </div>
                          </div>    
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-dismiss="modal">Salir</button>
                          <button type="submit" class="btn btn-primary"> Guardar Cambios </button>

                        </div>
                    </form>
                 </div>
            </div>
        </div>                                     
        <!----/MODAL AGREGAR EMPLEADO---->  
        
        </div>
       <!--/App OrdenServicios-->
  </div>
<%@include file="../../jspf/footer.jspf" %>
</div>
<!-- ./wrapper -->
<%-- Scripts persolaizado --%>
<script src="../../js/controller.js"></script>
<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="../../plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 4 -->

<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="../../plugins/chart.js/Chart.min.js"></script>
<!-- Sparkline -->
<script src="../../plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="../../plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="../../plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="../../plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="../../plugins/moment/moment.min.js"></script>
<script src="../../plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="../../plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="../../plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="../../plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="../../dist/js/pages/dashboard.js"></script>



</body>
</html>
