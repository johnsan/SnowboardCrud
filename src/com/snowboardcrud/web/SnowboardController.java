package com.snowboardcrud.web;

import javax.jdo.PersistenceManager;

import com.snowboardcrud.domain.Snowboard;
import com.snowboardcrud.repository.PMF;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
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
		
		//String brand = snowboard.getBrand();
		//String model = snowboard.getModel();
        //Snowboard snowboard = new Snowboard();

        PersistenceManager pm = PMF.get().getPersistenceManager();
        try {
            pm.makePersistent(snowboard);
        } catch (Exception e){
        	System.out.println(e);
        } finally {
            pm.close();
        }
		
		return "redirect:createSnowboard";
	}
	
	@RequestMapping("/createSnowboard")
	public ModelAndView showSnowboards() {
		return new ModelAndView("snowboard/createSnowboard", "command", new Snowboard());
	}
}
