package com.sun.curd.bean;

import java.util.Date;
import java.io.Serializable;

/**
 * (Admin)实体类
 *
 * @author makejava
 * @since 2021-05-31 16:54:51
 */
public class Admin implements Serializable {
    private static final long serialVersionUID = 497275371761007213L;
    
    private Integer layId;
    
    private String username;
    
    private String password;
    
    private Integer sex;
    
    private String eMail;
    
    private Date createtime;


    public Integer getLayId() {
        return layId;
    }

    public void setLayId(Integer layId) {
        this.layId = layId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getEMail() {
        return eMail;
    }

    public void setEMail(String eMail) {
        this.eMail = eMail;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "layId=" + layId +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", sex=" + sex +
                ", eMail='" + eMail + '\'' +
                ", createtime=" + createtime +
                '}';
    }
}