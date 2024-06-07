/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.util.Date;



/**
 *
 * @author ROBOT
 */
public class Empleado {
    private int codEmp;
    private String apellidos;
    private String nombres;
    private String genero;
    private String tipoDoc;
    private String numDoc;
    private String tel;
    private String email;
    private String dist;
    private Date fecNac;
    private String nacionalidad;
    private String direccion;
    private String eCivil;
    private String sucursal;
    private int estadoEmp;
    private int nroHijos;
    private byte[] imagen;

    public Empleado() {
    }

    public Empleado(int codEmp, String apellidos, String nombres, String genero, String tipoDoc, String numDoc, String tel, String email, String dist, Date fecNac, String nacionalidad, String direccion, String eCivil, String sucursal, int estadoEmp, int nroHijos, byte[] imagen) {
        this.codEmp = codEmp;
        this.apellidos = apellidos;
        this.nombres = nombres;
        this.genero = genero;
        this.tipoDoc = tipoDoc;
        this.numDoc = numDoc;
        this.tel = tel;
        this.email = email;
        this.dist = dist;
        this.fecNac = fecNac;
        this.nacionalidad = nacionalidad;
        this.direccion = direccion;
        this.eCivil = eCivil;
        this.sucursal = sucursal;
        this.estadoEmp = estadoEmp;
        this.nroHijos = nroHijos;
        this.imagen = imagen;
    }

    public Empleado(String apellidos, String nombres, String genero, String tipoDoc, String numDoc, String tel, String email, String dist, Date fecNac, String nacionalidad, String direccion, String eCivil, String sucursal, int estadoEmp, int nroHijos, byte[] imagen) {
        this.apellidos = apellidos;
        this.nombres = nombres;
        this.genero = genero;
        this.tipoDoc = tipoDoc;
        this.numDoc = numDoc;
        this.tel = tel;
        this.email = email;
        this.dist = dist;
        this.fecNac = fecNac;
        this.nacionalidad = nacionalidad;
        this.direccion = direccion;
        this.eCivil = eCivil;
        this.sucursal = sucursal;
        this.estadoEmp = estadoEmp;
        this.nroHijos = nroHijos;
        this.imagen = imagen;
    }

    public int getCodEmp() {
        return codEmp;
    }

    public void setCodEmp(int codEmp) {
        this.codEmp = codEmp;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getTipoDoc() {
        return tipoDoc;
    }

    public void setTipoDoc(String tipoDoc) {
        this.tipoDoc = tipoDoc;
    }

    public String getNumDoc() {
        return numDoc;
    }

    public void setNumDoc(String numDoc) {
        this.numDoc = numDoc;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDist() {
        return dist;
    }

    public void setDist(String dist) {
        this.dist = dist;
    }

    public Date getFecNac() {
        return fecNac;
    }

    public void setFecNac(Date fecNac) {
        this.fecNac = fecNac;
    }

    public String getNacionalidad() {
        return nacionalidad;
    }

    public void setNacionalidad(String nacionalidad) {
        this.nacionalidad = nacionalidad;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String geteCivil() {
        return eCivil;
    }

    public void seteCivil(String eCivil) {
        this.eCivil = eCivil;
    }

    public String getSucursal() {
        return sucursal;
    }

    public void setSucursal(String sucursal) {
        this.sucursal = sucursal;
    }

    public int getEstadoEmp() {
        return estadoEmp;
    }

    public void setEstadoEmp(int estadoEmp) {
        this.estadoEmp = estadoEmp;
    }

    public int getNroHijos() {
        return nroHijos;
    }

    public void setNroHijos(int nroHijos) {
        this.nroHijos = nroHijos;
    }

    public byte[] getImagen() {
        return imagen;
    }

    public void setImagen(byte[] imagen) {
        this.imagen = imagen;
    }

    
    
}
