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
  
    <!-- DataTables -->
  <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
      <!-- Select2 -->
  <link rel="stylesheet" href="../../plugins/select2/css/select2.min.css">
  <link rel="stylesheet" href="../../plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
  
  <link rel="stylesheet" href="../../css/style.css">
  
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Incluir Vue.js -->
   <script src="../../plugins/vue/vue.js"></script>
   <!-- Script de la Aplicación Vue.js -->
   <script src="../../js/app.js"></script>
    
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
  

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" id="mainContent">
        <!--/App OrdenServicios-->
       <div class="card container-fluid" id="aplicacion">
            <!-- Card-Header -->
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
            
            <!-- Card-Body -->
            <div class="card-body">
              <div class="row">
              <!-- Columna del formulario -->
              <div class="col-md-9">
                <!-- Card Fromulario Detalle Servicios-->  
                <div class="card shadow-lg tarjetaSombreada">
                    <form action='#'  >
                    <div class="card-header">
                        <h5 class="card-title">Detalle Servicio</h5>
                        <div class="card-tools divflex">
                            <div>Fecha: {{fecha}} Hora {{hora}}</div>
                        </div>  
                    </div>

                    <div class="form-inline formularioDetalleSrvicio">
                      <div class="form-row">
                        <div class="form-group col-lg-4">
                            
                           <label for="nroOrden" >NRO:</label>
                           <%  
                               Orden ordn = new Orden();
                               String nroOrden = ordn.generarNroOrden();
                           %>
                           <input type="text" class="form-control" value="<%=nroOrden%>" id="nroOrden" name="nroOrden" placeholder="Numero de Orden" readonly>
                        </div>
                        <div class="form-group col-lg-4">
                            <label>Delivery:</label><br>
                            <div class="form-check form-check-inline">
                              <input class="form-check-input" type="radio" name="delivery" id="delivery_si" value="si">
                              <label class="form-check-label" for="delivery_si">Sí</label>
                            </div>
                            <div class="form-check form-check-inline">
                              <input class="form-check-input" checked type="radio" name="delivery" id="delivery_no" value="no">
                              <label class="form-check-label" for="delivery_no">No</label>
                            </div>
                        </div>
                        <div class="form-group col-lg-4">
                          <label>Fecha Delivery:</label>
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
                            <label for="buscarCliente">Cliente:</label>
                            <div class="input-group gcliente">
                              <input type="text" class="form-control" id="buscarCliente" name="buscarCliente" placeholder="Buscar cliente" data-toggle="modal" data-target="#modalBuscarCliente" aria-describedby="btnAgregarCliente">
                              <div class="input-group-append align-rigth">
                                <button class="btn btn-outline-secondary" type="button" id="btnAgregarCliente" data-toggle="modal" data-target="#modalAgregarCliente">Nuevo Cliente</button>
                              </div>
                            </div>
                         </div>
                    </div>  

                       <div class="form-row">
                           <div class="form-group col-4">
                            <label for="cliDocIdentidad">Documento Identidad </label>
                            <input type="text" class="form-control" id="cliDocIdentidad" name="cliDocIdentidad" placeholder="Numero de Documento" readonly>
                           </div>
                           <div class="form-group col-4">
                            <label for="email">Email: </label>
                            <input type="email" class="form-control" id="clienteEmail" placeholder="Correo Electronico" readonly>
                           </div>
                           <div class="form-group col-4">
                            <label for="direccion">Direccion: </label>
                            <input type="text" class="form-control" id="clienteDireccion" placeholder="Dirección" readonly>
                           </div>
                       </div>

                      <div class="form-row">
                        <div class="form-group col-5">
                          <label for="fecRecep" >Fecha de Recepción:</label>

                          <div class="input-group">
                            <div class="input-group-prepend">
                              <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                            </div>
                            <input type="text" v-model="fecha" id="fecRecep" name="fecRecep" class="form-control" readonly>
                          </div>
                        </div>
                          
                        <div class="form-group col-2">
                            <label>Dias</label>
                            <div class="input-group">
                              <input type="number" v-model="tiempoDemora" class="form-control"  id="demoraDias">
                            </div>
                        </div>
                          
                        <div class="form-group col-5">
                          <label for="fecEntrega" >Fecha de Entrega:</label>

                          <div class="input-group">
                            <div class="input-group-prepend">
                              <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                            </div>
                            <input type="text" v-model="fechaEntrega" class="form-control"  id="fecEntrega" name="fecEntrega" data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy" data-mask>
                          </div>
                          <!-- /.input group -->
                        </div>
                      </div>
                      <div class="form-row">
                          <div class="form-group col-7">
                            <label for="inputEmp">Empleado:</label>
                            <div class="input-group empInpt">
                              <input type="text" class="form-control" v-model="username" id="inputEmpleado" placeholder="Nombre Empleado" readonly>
                            </div>
                          </div>
                          <input type="hidden" v-model="empDocId" id="empDocIdentidad" name="empDocIdentidad">
                          
                          <div class="form-group col-5">
                            <label for="inputEmp">Hora De Entrega:</label>
                            <div class="input-group horaentInpt">
                              <input type="text" value="18:00:00" class="form-control" id="horaEntrega" name="horaEntrega">
                            </div>
                          </div>

                      </div>    
                    </div>

                        <!-- Card Table Detalle Servicios-->
                    <div class="card">
                        <div class="card-body table-responsive p-0" style="height: 200px;">
                          <table class="table table-head-fixed text-nowrap" class="table-hover" id="tablaDetalles">
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
                                       <i class='fas fa-trash rmv-ico' ></i>
                                    </span>

                                </td>
                                <td>
                                   <span>
                                       {{index +1}}
                                   </span>
                                </td>
                                <td><input v-model="detalle.cantidad" name="cantidad" id="cantidad" class='tbDetailsCantInpt'></td>
                                <td>{{detalle.tipoServ}}</td>
                                <td>{{detalle.prenda}}</td>
                                <td>{{detalle.precio}}</td>
                                <td>{{detalle.cantidad * detalle.precio}}</td>
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
                            <div class="form-group col">
                                <label for="telefono">Total</label>
                                <input type="text"  v-model="total" class="form-control" id="total" readonly>
                            </div>  
                            <div class="form-group col">
                                <label for="telefono">A Cuenta</label>
                                <input type="text" v-model="acuenta" class="form-control" id="aCuenta" readonly>

                            </div>  
                            <div class="form-group col">
                                <label for="telefono">Saldo: </label>
                                <input type="text" v-model="saldo" class="form-control" id="saldo" readonly>
                            </div>

                            <div class='form-group col-4' >
                                <button type='button' class='btn btn-success' data-toggle="modal" data-target="#miniModalAddPago" > Agregar Pago</button>

                                <button type='button' class="btn btn-success" id="btnImprimirFactura" @click="printFact"> Imprimir Factura</button>
                            </div>

                        </div>
                    </div>
                    <!-- /botones del footer del card principal detalle servicios -->  
                    </form>
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
                            <div class="input-group">
                              <input type="text"class="form-control" id="searchInput" placeholder="Buscar prenda..." @input="filterElems">
                            </div>
                           
                         </div>

                         <div class="m-3">
                             <div class="form-group">
                                <label>Tipo de Servicio</label>
                                <select class="form-control" name="tipoServ" id="tipoServ" style="width: 100%;">
                                  <option v-for="(servicio, index) in tipoServicios" :key="index">{{servicio}}</option>
                                </select>
                            </div>  
                         </div>

                        <div id="itemsContainer">
                            <ul class="ul-treeItems" v-for="(treeData, i) in ListTreeData" :key="i" >

                              <tree-item @item-clicked=" agregarDetalle" class="item" :model="treeData"></tree-item>

                            </ul>
                        </div>
                           
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
            <div class="modal" id="modalBuscarCliente" tabindex="-1" role="dialog" aria-labelledby="modalBuscarCliente" aria-hidden="true">
              <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="background:#3c8dbc; color:white;">
                        <h4 class ="modal-title">  Buscar Clientes</h4>
                        <button type="button" class="close" data-dismiss="modal">
                            <i class="fa fa-times" aria-hidden="true"></i>
                        </button>
                     </div>
                     <div class="modal-body">
                         <div class="card-body">
                             
                             <!--Card Tabla de datos-->
                             <div class="card">
                                <div class="card-header">
                                  <h3 class="card-title">Registro de Clientes</h3>
                                </div>
                                <!-- /.card-header -->
                                <div class="card-body">
                                  <table id="tablaClientes" class="table table-bordered table-striped" @click="fillCliente">
                                    <thead>
                                    <tr>
                                      <th>Nombres</th>
                                      <th>Apellidos</th>
                                      <th>Numero de Documento</th>
                                      <th>Correo Electronico</th>
                                      <th>Direccion</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        try{
                                          String sql = "select Nombres, Apellidos, NumDocIdentidad, Email, Direccion  from tb_Cliente";
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
                                      <th>Nombres</th>
                                      <th>Apellidos</th>
                                      <th>Numero de Documento</th>
                                      <th>Correo Electronico</th>
                                      <th>Direccion</th>
                                    </tr>
                                    </tfoot>
                                  </table>
                                </div>
                                <!-- /.card-body -->
                              </div>
                              <!-- /.card -->

                         </div>
                     </div>
                </div> 
              </div>
            </div>
            <!--/MODAL Buscar Cliente-------------->   
            
            <!-- MINI MODAL AGREGAR PAGO -->
            <div class="modal" id="miniModalAddPago" tabindex="-1"  role="dialog" aria-labelledby="miniModalAddPago" aria-hidden="true" data-backdrop="static">
                <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background:#3c8dbc; color:white;">
                            <h4 class ="modal-title"> Agregar Pago</h4>
                            <button type="button" class="close" data-dismiss="modal">
                                <i class="fa fa-times" aria-hidden="true"></i>
                            </button>
                            
                        </div>
                        <div class="modal-body">
                            <form>
                                <div class="form-group col">
                                    <label for="telefono">Total a Pagar</label>
                                    <input type="text"  v-model="total" class="form-control" id="total" readonly>
                                </div>  
                                <div class="form-group col">
                                    <label for="telefono">Agregar Pago S/.</label>
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
                          <button class="btn btn-primary" data-dismiss="modal"> Guardar Pago </button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /MINI MODAL AGREGAR PAGO -->
        </div>
       <!--/App OrdenServicios-->
      
       
        <!----MODAL AGREGAR CLIENTE---->  
        <div class="modal" id="modalAgregarCliente" tabindex="-1" role="dialog" aria-labelledby="modalAgregarCliente" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <div id="formRegClientes">
                        <div class="content">

                            <section class="content-header">
                                <div class="container-fluid">
                                    <div class="row mb-2">
                                        <div class="col-sm-6">
                                            <h1>Nuevo Cliente</h1>
                                        </div>
                                       <button type="button" class="close" data-dismiss="modal">
                                            <i class="fa fa-times" aria-hidden="true"></i>
                                        </button>
                                    </div> 
                                </div>
                            </section>

                            <section class="content">
                                <div class="card">
                                    <div class="card-body">
                                        <form  action="/Web_SistemaLavanderiaControl_SLC/ClientesLet" method="post" >
                                            <input type="hidden" name="accion" value="INS">

                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="form-group">
                                                      <label for="cliApellidos">Apellidos</label>
                                                      <input type="text" class="form-control" id="cliApellidos" name="cliApellidos" placeholder="Apellidos">
                                                    </div>  
                                                    <div class="form-group">
                                                      <label for="cliNombres">Nombres</label>
                                                      <input type="text" class="form-control" id="cliNombres"  name="cliNombres" placeholder="Nombres">
                                                    </div> 
                                                    <div class="form-group">
                                                      <label for="cliGenero">Genero</label>
                                                      <select class="form-control select2" name="cliGenero" id="cliGenero">

                                                          <option>Masculino</option>
                                                          <option>Femenino</option>
                                                          <option>Otro</option>
                                                          <option>Prefiero No decirlo</option>
                                                      </select>
                                                    </div> 
                                                    <div class="form-group">
                                                        <label for="selectTipoDoc" >Tipo de Documento</label>
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
                                                    <div class="form-group">
                                                      <label for="cliNumDoc">Numero de Documento de Identidad</label>
                                                      <input type="text" class="form-control" id="cliNumDoc"  name="cliNumDoc" placeholder="Numero de Documento">
                                                    </div> 
                                                    <div class="form-group">
                                                      <label for="cliTelef">Numero Telefonico</label>
                                                      <input type="text" class="form-control" id="cliTelef"  name="cliTelef" placeholder="Telefóno">
                                                    </div> 
                                                    <div class="form-group">
                                                      <label for="cliEmail">Correo Electronico</label>
                                                      <input type="email" class="form-control" id="cliEmail" name="cliEmail" placeholder="Email">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="selectNac" >Nacionalidad</label>
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
                                                    <div class="form-group">
                                                      <label>Departamento</label>

                                                      <select class="form-control select2" id="selectDep" name="selectDep" style="width: 100%;" @change="prov">
                                                          <option selected="selected">Lima</option>
                                                          <option v-for="(dep, index) in departamentos" :key="index">{{dep}}</option>
                                                      </select>
                                                   </div>
                                                    <div class="form-group">
                                                        <label>Provincia</label>
                                                        <select class="form-control select2" id="selectProv" name="selectProv" style="width: 100%;"  @change="dist">
                                                            <option v-for="(prov, index) in provincias" :key="index" >{{prov}}</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="selectDist">Distrito</label>
                                                        <select class="form-control select2" id="selectDist" name="selectDist" style="width: 100%;">
                                                            <option v-for="(dist, index) in distritos" :key="index" >{{dist}}</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                      <label for="cliDir">Direccion</label>
                                                      <input type="text" class="form-control" id="cliDir" name="cliDir" placeholder="Direccion">
                                                    </div> 
                                                    <div class="form-group">
                                                      <label for="cliFecNac">Fecha de Nacimiento</label>
                                                        <div class="input-group date" id="reservationdate"  data-target-input="nearest">
                                                            <input type="text" class="form-control datetimepicker-input" name="cliFecNac" id="cliFecNac" data-target="#reservationdate"/>
                                                            <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                                                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                      <label for="cliEstCivil">Estado Civil</label>
                                                      <input type="text" class="form-control" id="cliEstCivil" name="cliEstCivil" placeholder="Estado Civil">
                                                    </div> 
                                                    <div class="form-group" >
                                                      <label for="cliFecReg">Fecha de Registro</label>
                                                      <input type="text"  v-model="fechaActual" name ="cliFecReg"  id="cliFecReg" class="form-control" readonly placeholder="Fecha de registro" >
                                                    </div> 


                                                </div>
                                                <div class="card-footer ">
                                                    <center>
                                                        <button type="submit" class="btn btn-primary">Guardar Datos</button>
                                                    </center>
                                                </div> 
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
                 </div>
            </div>
        </div>                                     
        <!----/MODAL AGREGAR CLIENTE---->  
  </div>
  
  
  <%@include file="../jspf/footer.jspf" %>
</div>
<!-- ./wrapper -->
<script src="../../js/controller.js"></script>
<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="../../plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Select2 -->
<script src="../../plugins/select2/js/select2.full.min.js"></script>
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


<!-- DataTables  & Plugins -->
<script src="../../plugins/datatables/jquery.dataTables.min.js"></script>
<script src="../../plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="../../plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="../../plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="../../plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="../../plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="../../plugins/jszip/jszip.min.js"></script>
<script src="../../plugins/pdfmake/pdfmake.min.js"></script>
<script src="../../plugins/pdfmake/vfs_fonts.js"></script>
<script src="../../plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="../../plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="../../plugins/datatables-buttons/js/buttons.colVis.min.js"></script>

<script>
  $(function () {
      
    $("#tablaClientes").DataTable({
      "responsive": true, "lengthChange": false, "autoWidth": false
    });
    $("#tablaOrdenesServicio").DataTable({
      "responsive": true, "lengthChange": false, "autoWidth": false,
      "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
    }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
    
    
    
  });
</script>
<!-- ./wrapper -->
<script src="../../js/registroCliente.js"></script>

</body>
</html>
