package com.example.edms.exception;

/**
 * Exception thrown when a document is not found.
 */
public class DocumentNotFoundException extends EDMSException {

    private static final long serialVersionUID = 1L;

    public DocumentNotFoundException() {
        super();
    }

    public DocumentNotFoundException(String message) {
        super(message);
    }

    public DocumentNotFoundException(Long documentId) {
        super("Document not found with ID: " + documentId);
    }

    public DocumentNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }
}
