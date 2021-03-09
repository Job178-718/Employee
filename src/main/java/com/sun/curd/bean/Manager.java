package com.sun.curd.bean;

import java.util.Date;

public class Manager {
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
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String geteMail() {
        return eMail;
    }

    public void seteMail(String eMail) {
        this.eMail = eMail == null ? null : eMail.trim();
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "Manager{" +
                "layId=" + layId +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", sex=" + sex +
                ", eMail='" + eMail + '\'' +
                ", createtime=" + createtime +
                '}';
    }
}