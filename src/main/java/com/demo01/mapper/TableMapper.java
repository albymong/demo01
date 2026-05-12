package com.demo01.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.demo01.model.Table;

@Mapper
public interface TableMapper {
    List<Table> findAll();
    Table findById(@Param("id") long id);
    List<Table> findAllTableNames();
    List<Table> findColumnsByTableName(@Param("tableName") String tableName);
}