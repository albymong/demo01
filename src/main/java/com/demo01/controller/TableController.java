package com.demo01.controller;

import com.demo01.dao.TableDao;
import com.demo01.model.Table;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class TableController {

    @Autowired
    private TableDao tableDao;

    @GetMapping("/table")
    public String list(Model model) {
        List<Table> tables = tableDao.findAllTableNames();
        model.addAttribute("tables", tables);
        return "table/list";
    }

    @GetMapping("/table/{tableName}")
    public String detail(@PathVariable("tableName") String tableName, Model model) {
        List<Table> columns = tableDao.findColumnsByTableName(tableName);
        model.addAttribute("tableName", tableName);
        model.addAttribute("columns", columns);
        return "table/detail";
    }
}