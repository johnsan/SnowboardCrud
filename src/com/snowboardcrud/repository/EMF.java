package com.snowboardcrud.repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.springframework.stereotype.Component;

@Component
public class EMF {
    
	private static final EntityManagerFactory emfInstance =
        Persistence.createEntityManagerFactory("transactions-optional");

    public EMF() {}

    public EntityManager entityManager() {
        return emfInstance.createEntityManager();
    }
    
    public static EntityManagerFactory get() {
        return emfInstance;
    }
}