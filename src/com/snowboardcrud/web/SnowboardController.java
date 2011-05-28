package com.snowboardcrud.web;

import javax.persistence.EntityManager;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.snowboardcrud.domain.Snowboard;
import com.snowboardcrud.repository.EMF;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/snowboard")
public class SnowboardController {

	@RequestMapping(value = "/processCreateSnowboard", method = RequestMethod.POST)
	public String processCreateSnowboard(@ModelAttribute("snowboard")
							Snowboard snowboard, BindingResult result) {
		
		System.out.println("Brand:" + snowboard.getBrand() + " " +
					"Model:" + snowboard.getModel());

		EntityManager em = EMF.get().createEntityManager();
        try {
        	em.persist(snowboard);
        } catch (Exception e){
        	System.out.println(e);
        } finally {
        	em.close();
        }
		
		return "redirect:createSnowboard";
	}
	
	@RequestMapping(value = "/deleteSnowboard/{id}")
	public String processDeleteSnowboard(@PathVariable ("id") String id) {
		
		Key key = KeyFactory.stringToKey(id);
		System.out.println("Snowboard with key:" + key + " " +
					"--- Ready For Deletion");

        EntityManager em = EMF.get().createEntityManager();
        try {
        	Snowboard snowboard = em.find(Snowboard.class, key);
        	em.remove(snowboard);
        } catch (Exception e){
        	System.out.println(e);
        } finally {
        	em.close();
        }
	
		return "redirect:/snowboard/createSnowboard";
	}
	
	@RequestMapping(value = "/ajaxUpdate/{id}/{newValue}", method = RequestMethod.POST)
	public String ajaxUpdate(@PathVariable ("id") String id, 
			@PathVariable ("newValue") String newValue){

		String[] array = id.split("\\_");
		EntityManager em = EMF.get().createEntityManager();
        try {
        	Key key = KeyFactory.stringToKey(array[0]);
        	Snowboard snowboard = em.find(Snowboard.class, key);
        	if(array[1].equals("Brand")){
        		snowboard.setBrand(newValue);
        	}else if(array[1].equals("Model")){
        		snowboard.setModel(newValue);
        	}else if(array[1].equals("Length")){
        		snowboard.setLength(Short.valueOf(newValue));
        	}else{
        		snowboard.setSnowsportGenre(newValue);
        	}
        } catch (Exception e){
        	System.out.println(e);
        } finally {
            em.close();
        }
		
		return null;
	}
	
	@RequestMapping("/createSnowboard")
	public ModelAndView showSnowboards() {
		return new ModelAndView("snowboard/createSnowboard", "command", new Snowboard());
	}
}
