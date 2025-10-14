package com.example.form;

import org.apache.struts.action.ActionForm;

/**
 * Sample Struts Form Bean for Legacy Java 5 Environment
 */
public class SampleForm extends ActionForm {

    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void reset() {
        this.name = null;
    }
}
