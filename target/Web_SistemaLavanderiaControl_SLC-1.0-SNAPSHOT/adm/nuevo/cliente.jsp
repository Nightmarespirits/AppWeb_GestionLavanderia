<%-- 
    Document   : cliente
    Created on : 15/04/2024, 06:36:50 PM
    Author     : Tutaya Rivera Clider Fernando
--%>

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
                    <h1> Nuevo Registro de Cliente</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <a href="#">Home</a> 
                        </li>
                        <li class="breadcrumb-item">
                            
                            <a href="#">Nuevo</a> 
                        </li>
                        <li class="breadcrumb-item active">
                            <a href="#">Cliente</a> 
                        </li>
                    </ol>
                </div>
            </div>
        </div>
</section>
<section class="content">
    <div class="card" >
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
            <form method="post" action="/Web_SistemaLavanderiaControl_SLC/ClientesLet">
                <div class="card-body">
                    <div class="form-group">
                      <label for="Apellidos">Apellidos</label>
                      <input type="text" class="form-control" id="cliApellidos" placeholder="Apellidos">
                    </div>  
                    <div class="form-group">
                      <label for="Nombres">Nombres</label>
                      <input type="text" class="form-control" id="cliNombres" placeholder="Nombres">
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
                    <div class="card-footer ">
                        <center>
                            <button type="submit" class="btn btn-primary" name="accion" value="INS">Guardar Datos</button>
                        </center>
                    </div>   
                </div>
            </form>
        <div class="card-footer">
            Pie de Pagina
        </div>
    </div>
</section>
