package com.snowboardcrud.domain;

import com.google.appengine.api.datastore.Key;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Snowboard {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Key key;

    private String brand;

    private String model;
    
    private Short length;

    private String snowsportGenre;

    public Key getKey() {
        return key;
    }

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getBrand() {
		return brand;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getModel() {
		return model;
	}

	public void setLength(Short length) {
		this.length = length;
	}

	public Short getLength() {
		return length;
	}

	public void setSnowsportGenre(String snowsportGenre) {
		this.snowsportGenre = snowsportGenre;
	}

	public String getSnowsportGenre() {
		return snowsportGenre;
	}

}