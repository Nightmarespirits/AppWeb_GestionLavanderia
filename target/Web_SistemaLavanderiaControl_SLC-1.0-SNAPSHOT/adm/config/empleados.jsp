<%-- 
    Document   : empleados
    Created on : 17/04/2024, 05:21:46 PM
    Author     : ROBOT
--%>

<%@page import="Model.EmpleadoDAO"%>
<%@page import="java.util.List"%>
<%@page import="Model.UsuarioDao"%>
<%@page import="config.Conexion"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
Conexion cnx = new Conexion();
Connection cn = cnx.getCn();
%>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Administrar Empleados</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item">
                        <a href="#">Inicio</a> 
                    </li>
                    <li class="breadcrumb-item">
                       Ajustes
                    </li>
                    <li class="breadcrumb-item active">
                       Empleados
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
            Nuevo Empleado
        </button>


        </div>
        <div class="card-body">
            <table width="100%" class="table-bordered table-striped table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Nombres</th>
                        <th>Nro Documento</th>
                        <th>Cargo</th>
                        <th>Telefono</th>
                        <th>Email</th>
                        <th>Distrito</th>
                        <th>Acciones</th>

                    </tr>
                </thead>


                <tbody>
                    <%
                    EmpleadoDAO empDao = new EmpleadoDAO();
                    List lista = empDao.listarEmp();

                    for(int i=0; i < lista.size();i++){
                        Object fila[] = (Object[]) lista.get(i);

                    %>
                    <tr>
                        <td><%=fila[0]%></td>
                        <td><%=fila[1]%></td>
                        <td><%=fila[2]%></td>
                        <td><%=fila[3]%></td>
                        <td><%=fila[4]%></td>
                        <td><%=fila[5]%></td>
                        <td><%=fila[6]%></td>
                        <td>
                            <button class="btn btn-warning" data-toggle="modal" data-target="#modalEditarEmp">
                                <i class="fa fa-edit"></i>
                            </button>

                            <button class="btn btn-danger" data-toggle="modal" data-target="#modalEliminarEmp">
                                <i class="fas fa-trash"></i>
                            </button>
                            <button class="btn btn-danger" data-toggle="modal" data-target="#modalVerContrato">
                                <i class="fas fa-shekel"></i>
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

<!-- Modal AGREGAR EMPLEADO-->
<div class="modal fade" id="modalAgregarUsuario" tabindex="-1" role="dialog" aria-labelledby="modalAgregarUsuario" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
        <form method="post" action="/SistemaWeb_LavanderiaControl/server" enctype="multipart/form-data">
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
                                <img src="#" class="img-thumbnail" width="100px">
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
        <form action="" method="" rol="form" enctype="mutipart/form-data">
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
              <button type="button" class="btn btn-danger" data-dismiss="modal">Eliminar Usuario</button>
            </div>
          
        </form>
    </div> 
  </div>
</div>


