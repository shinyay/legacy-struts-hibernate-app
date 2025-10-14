package com.example.edms.exception;

/**
 * Base exception class for EDMS-specific errors.
 * All custom exceptions in the EDMS should extend this class.
 */
public class EDMSException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    private String errorCode;

    public EDMSException() {
        super();
    }

    public EDMSException(String message) {
        super(message);
    }

    public EDMSException(String message, Throwable cause) {
        super(message, cause);
    }

    public EDMSException(Throwable cause) {
        super(cause);
    }

    public EDMSException(String errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
    }

    public EDMSException(String errorCode, String message, Throwable cause) {
        super(message, cause);
        this.errorCode = errorCode;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }
}
