<%-- 
    Document   : ordenesServicio
    Created on : 26/04/2024, 08:14:29 PM
    Author     : Tutaya Rivera Clider Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="container" >
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
            <div class="card-body">
                <table id="tablaOrdenesServicio" width="100%" class="table-bordered table-hover table-striped table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Nombre</th>
                            <th>Usuario</th>
                            <th>Foto</th>
                            <th>Perfil</th>
                            <th>Estado</th>
                            <th>Ultimo Acceso</th>
                            <th>Acciones</th>
                            
                        </tr>
                    </thead>
                        
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>Juan Perez </td>
                            <td>Admin</td>
                            <td> </td>
                            <td>Admin </td>
                            <td> 
                                <button class="btn btn-success">
                                    Activado
                                </button>
                            </td>
                            <td>12/12/12 </td>
                            <td>
                                <button class="btn btn-warning">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-danger">
                                    <i class="fas fa-trash text-white"></i>
                                </button>
                            
                            </td>
                        </tr>
                         <tr>
                            <td>2</td>
                            <td>Clider Fernando </td>
                            <td>Admin</td>
                            <td> </td>
                            <td>Admin </td>
                            <td> 
                                <button class="btn btn-danger">
                                    Desactivado
                                </button>
                            </td>
                            <td>12/10/12 </td>
                            <td>Ninguna</td>
                        </tr>
                         <tr>
                            <td>3</td>
                            <td>Juana Arce </td>
                            <td>Admin</td>
                            <td> </td>
                            <td>Admin </td>
                            <td> Activo</td>
                            <td>12/12/12 </td>
                            <td>Ninguna</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Jhoan Romani </td>
                            <td>Admin</td>
                            <td> </td>
                            <td>Admin </td>
                            <td> Activo</td>
                            <td>12/12/12 </td>
                            <td>Ninguna</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Juan Ordonies </td>
                            <td>Admin</td>
                            <td> </td>
                            <td>Admin </td>
                            <td> Activo</td>
                            <td>12/12/12 </td>
                            <td>Ninguna</td>
                        </tr>
                    </tbody>
                    
                    <tfoot>
                        
                    </tfoot>
                </table>
            </div>
            <div class="card-footer">
                Footer
            </div>
        </div>   
    </section>
</div>