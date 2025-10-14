package com.example.edms.exception;

/**
 * Exception thrown when a user attempts an unauthorized action.
 */
public class UnauthorizedAccessException extends EDMSException {

    private static final long serialVersionUID = 1L;

    public UnauthorizedAccessException() {
        super();
    }

    public UnauthorizedAccessException(String message) {
        super(message);
    }

    public UnauthorizedAccessException(String username, String resource) {
        super("User '" + username + "' is not authorized to access: " + resource);
    }

    public UnauthorizedAccessException(String message, Throwable cause) {
        super(message, cause);
    }
}
