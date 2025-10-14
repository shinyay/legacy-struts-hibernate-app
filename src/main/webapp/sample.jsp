<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>

<html>
<head>
    <title>Sample Form - Java 5 Legacy App</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <jsp:include page="/includes/header.jsp" />
    <script type="text/javascript">
        $(document).ready(function() {
            // Add jQuery validation
            $('#name').on('blur', function() {
                var name = $(this).val().trim();
                if (name.length === 0) {
                    $(this).css('border-color', 'red');
                    $('#nameError').text('Name is required').show();
                } else if (name.length < 3) {
                    $(this).css('border-color', 'orange');
                    $('#nameError').text('Name should be at least 3 characters').show();
                } else {
                    $(this).css('border-color', 'green');
                    $('#nameError').hide();
                }
            });

            // Add form animation
            $('.form-table').hide().fadeIn(1000);
        });
    </script>
</head>
<body>
    <div class="container">
        <h1>📝 Sample Struts Form</h1>
        <p>Enter your name to test the Struts Action:</p>

        <html:form action="/sample">
            <table class="form-table">
                <tr>
                    <td><label for="name">Your Name:</label></td>
                    <td>
                        <html:text property="name" size="30" styleId="name"/>
                        <div id="nameError" style="color: red; font-size: 12px; display: none;"></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="submit-row">
                        <html:submit value="Submit" styleClass="btn"/>
                        <html:reset value="Reset" styleClass="btn btn-secondary"/>
                    </td>
                </tr>
            </table>
        </html:form>

        <p><a href="index.jsp">← Back to Home</a></p>
    </div>
    <jsp:include page="/includes/footer.jsp" />
</body>
</html>
