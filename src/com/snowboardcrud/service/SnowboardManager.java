package com.snowboardcrud.service;

import java.util.List;

import com.snowboardcrud.domain.Snowboard;
import com.snowboardcrud.repository.SnowboardJPA;

public class SnowboardManager {
	
	private SnowboardJPA snowboardJpa = new SnowboardJPA();

	public List<Snowboard> getSnowboardList() {
		return snowboardJpa.getSnowboardList();
	}
	
	public void createSnowboard(Snowboard snowboard){
		snowboardJpa.createSnowboard(snowboard);
	}
	
	public void deleteSnowboard(Long id){
		snowboardJpa.deleteSnowboard(id);
	}
	
	public void updateSnowboard(Long id, String fieldModified, String newValue){
		snowboardJpa.updateSnowboard(id, fieldModified, newValue);
	}
	
}
