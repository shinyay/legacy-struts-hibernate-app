package com.example.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.example.form.SampleForm;

/**
 * Sample Struts Action for Legacy Java 5 Environment
 */
public class SampleAction extends Action {

    public ActionForward execute(ActionMapping mapping,
                               ActionForm form,
                               HttpServletRequest request,
                               HttpServletResponse response) throws Exception {

        SampleForm sampleForm = (SampleForm) form;

        // Business logic here
        String message = "Hello, " + sampleForm.getName() + "! Welcome to Java 5 Legacy Development.";
        request.setAttribute("message", message);

        return mapping.findForward("success");
    }
}
