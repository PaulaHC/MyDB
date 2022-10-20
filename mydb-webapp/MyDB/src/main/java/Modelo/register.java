/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo; 
/**
 *
 * @author paula
 */
public class register {
    private String name;
    private String subname;
    private String email;
    private String password;

    public void setName(String name) {
        this.name = name;
    }

    public void setSubname(String subname) {
        this.subname = subname;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }
  
    public String getName() {
            return name;
        }

    public String getSubname() {
        return subname;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }
    }
