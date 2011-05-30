package com.snowboardcrud.repository;

import java.util.List;
import java.util.logging.Logger;

import javax.persistence.EntityManager;

import com.snowboardcrud.domain.Snowboard;

public class SnowboardJPA {
 
	private static List<Snowboard> snowboardList;
	private static final Logger log = Logger.getLogger(SnowboardJPA.class.getName());
 
	public List<Snowboard> getSnowboardList() {
		log.info("Retreiving snowboard list...");
		
		EntityManager em = EMF.get().createEntityManager();
		String query = "select from " + Snowboard.class.getName() + " order by brand, model asc range 0,30";
		snowboardList = (List<Snowboard>) em.createQuery(query).getResultList();
		
		return snowboardList;
	}	
	
	public boolean createSnowboard(Snowboard snowboard){
		
		log.info("Creating snowboard... " +
				"Brand: " + snowboard.getBrand() + " " +
				"Model: " + snowboard.getModel() + " " +
				"Length: " + snowboard.getLength() + " " +
				"Genre: " + snowboard.getGenre());
		
		boolean sucess = true;
		
		EntityManager em = EMF.get().createEntityManager();
		try {
        	em.persist(snowboard);
        } catch (Exception e){
        	System.out.println(e);
        	sucess = false;
        } finally {
        	em.close();
        }
		
		return sucess;
	}
	
	public boolean deleteSnowboard(Long id){
		
		log.info("Deleting snowboard with id: " + id);
		
		boolean sucess = true;
		
		EntityManager em = EMF.get().createEntityManager();
		try{
			Snowboard snowboard = em.find(Snowboard.class, id);
	    	em.remove(snowboard);	
		} catch (Exception e){
        	System.out.println(e);
        	sucess = false;
        } finally {
        	em.close();
        }
		
		return sucess;
	}
	
	public boolean updateSnowboard(Long id, String fieldModified, String newValue){

		log.info("Updating snowboard with id: " + id);
		
		boolean sucess = true;
		
		EntityManager em = EMF.get().createEntityManager();
        try {
        	Snowboard snowboard = em.find(Snowboard.class, id);
        	if(fieldModified.equals("Brand")){
        		snowboard.setBrand(newValue);
        	}else if(fieldModified.equals("Model")){
        		snowboard.setModel(newValue);
        	}else if(fieldModified.equals("Length")){
        		snowboard.setLength(Short.valueOf(newValue));
        	}else{
        		snowboard.setGenre(newValue);
        	}
        } catch (Exception e){
        	System.out.println(e);
        	sucess = false;
        } finally {
            em.close();
        }
		
		return sucess;
	}
}