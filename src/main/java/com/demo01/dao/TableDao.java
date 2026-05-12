package com.demo01.dao;

import com.demo01.mapper.TableMapper;
import com.demo01.model.Table;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TableDao {

    @Autowired
    private TableMapper tableMapper;

    public List<Table> findAll() {
        return tableMapper.findAll();
    }

    public Table findById(long id) {
        return tableMapper.findById(id);
    }

    public List<Table> findAllTableNames() {
        return tableMapper.findAllTableNames();
    }

    public List<Table> findColumnsByTableName(String tableName) {
        return tableMapper.findColumnsByTableName(tableName);
    }
}