package com.sun.curd.dao;

import com.sun.curd.bean.Admin;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * (Admin)表数据库访问层
 *
 * @author makejava
 * @since 2021-05-31 16:55:49
 */
@Component
public interface AdminDao {

    /**
     * 通过管理员查询
     * @param admin
     * @return
     */
    Admin queryAdmin(Admin admin);

    /**
     * 通过ID查询单条数据
     *
     * @param layId 主键
     * @return 实例对象
     */
    Admin queryById(Integer layId);

    /**
     * 查询指定行数据
     *
     * @param offset 查询起始位置
     * @param limit 查询条数
     * @return 对象列表
     */
    List<Admin> queryAllByLimit(@Param("offset") int offset, @Param("limit") int limit);


    /**
     * 通过实体作为筛选条件查询
     *
     * @param admin 实例对象
     * @return 对象列表
     */
    List<Admin> queryAll(Admin admin);

    /**
     * 新增数据
     *
     * @param admin 实例对象
     * @return 影响行数
     */
    int insert(Admin admin);

    /**
     * 修改数据
     *
     * @param admin 实例对象
     * @return 影响行数
     */
    int update(Admin admin);

    /**
     * 通过主键删除数据
     *
     * @param layId 主键
     * @return 影响行数
     */
    int deleteById(Integer layId);

}