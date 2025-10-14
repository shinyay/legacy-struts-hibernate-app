<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>

<!-- jQuery 1.12.4 - Last version supporting IE 6-8 and legacy browsers -->
<script src="https://code.jquery.com/jquery-1.12.4.min.js"
        integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
        crossorigin="anonymous"></script>

<!-- jQuery UI 1.12.1 - For UI components (optional) -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
        integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="
        crossorigin="anonymous"></script>

<!-- Application Stylesheet -->
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css">

<!-- Common JavaScript utilities -->
<script type="text/javascript">
    // Common JavaScript functions
    var APP_CONTEXT = '<%= request.getContextPath() %>';

    $(document).ready(function() {
        // Global jQuery initialization
        console.log('jQuery version: ' + $.fn.jquery);

        // Example: Add loading indicator for AJAX requests
        $(document).ajaxStart(function() {
            $('#loading').show();
        }).ajaxComplete(function() {
            $('#loading').hide();
        });
    });
</script>
