package com.example.models;

public class Carousel {

    private final String slide_id;
    private final String title;
    private final String imageUrl;
    private final String description;

    public Carousel(String slide_id, String title, String imageUrl, String description) {
        this.slide_id = slide_id;
        this.title = title;
        this.imageUrl = imageUrl;
        this.description = description;

    }

    public String getTitle() {
        return title;
    }

    public String getslide_id() {
        return slide_id;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public String getDescription() {
        return description;
    }
}
