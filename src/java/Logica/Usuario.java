/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

/**
 *
 * @author usuario
 */
public abstract class Usuario{
    protected String nickname;
    protected String nombre;
    protected String email;
    protected String direccion;
    
    public Usuario(String nickname, String nombre, String email, String direccion){
        this.nickname = nickname;
        this.nombre = nombre;
        this.email = email;
        this.direccion = direccion;
    } 
    
    public String getNickname(){
        return nickname;
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public String getEmail(){
        return email;
    }
    
    public String getDireccion(){
        return direccion;
    }
    
    public void setNickname(String nickname){
        this.nickname = nickname;
    }
    
    public void setNombre(String nombre){
        this.nombre = nombre;
    }
    
    public void setEmail(String email){
        this.email = email;
    }
    
    public void setDireccion(String direccion){
        this.direccion = direccion;
    }
    
    
    
}
