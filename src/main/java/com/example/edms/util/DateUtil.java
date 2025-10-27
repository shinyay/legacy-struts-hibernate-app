package com.example.edms.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Utility class for date and time operations.
 */
public class DateUtil {

    private static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd";
    private static final String DEFAULT_DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
    private static final String DISPLAY_DATE_FORMAT = "MMM dd, yyyy";
    private static final String DISPLAY_DATETIME_FORMAT = "MMM dd, yyyy HH:mm";

    /**
     * Format a date using the default format (yyyy-MM-dd).
     * 
     * @param date the date to format
     * @return formatted date string
     */
    public static String formatDate(Date date) {
        if (date == null) {
            return "";
        }
        return new SimpleDateFormat(DEFAULT_DATE_FORMAT).format(date);
    }

    /**
     * Format a date and time using the default format (yyyy-MM-dd HH:mm:ss).
     * 
     * @param date the date to format
     * @return formatted datetime string
     */
    public static String formatDateTime(Date date) {
        if (date == null) {
            return "";
        }
        return new SimpleDateFormat(DEFAULT_DATETIME_FORMAT).format(date);
    }

    /**
     * Format a date for display (MMM dd, yyyy).
     * 
     * @param date the date to format
     * @return formatted date string for display
     */
    public static String formatDateForDisplay(Date date) {
        if (date == null) {
            return "";
        }
        return new SimpleDateFormat(DISPLAY_DATE_FORMAT).format(date);
    }

    /**
     * Format a date and time for display (MMM dd, yyyy HH:mm).
     * 
     * @param date the date to format
     * @return formatted datetime string for display
     */
    public static String formatDateTimeForDisplay(Date date) {
        if (date == null) {
            return "";
        }
        return new SimpleDateFormat(DISPLAY_DATETIME_FORMAT).format(date);
    }

    /**
     * Get the current date and time.
     * 
     * @return current date
     */
    public static Date now() {
        return new Date();
    }

    /**
     * Check if a date is in the past.
     * 
     * @param date the date to check
     * @return true if date is in the past
     */
    public static boolean isPast(Date date) {
        return date != null && date.before(new Date());
    }

    /**
     * Check if a date is in the future.
     * 
     * @param date the date to check
     * @return true if date is in the future
     */
    public static boolean isFuture(Date date) {
        return date != null && date.after(new Date());
    }

    /**
     * Calculate the difference in days between two dates.
     * 
     * @param date1 first date
     * @param date2 second date
     * @return difference in days
     */
    public static long daysBetween(Date date1, Date date2) {
        if (date1 == null || date2 == null) {
            return 0;
        }
        long diff = date2.getTime() - date1.getTime();
        return diff / (24 * 60 * 60 * 1000);
    }

    private DateUtil() {
        // Prevent instantiation
    }
}
