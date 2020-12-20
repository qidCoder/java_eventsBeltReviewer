package com.events.services;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.events.models.Event;
import com.events.models.Message;
import com.events.models.User;
import com.events.repositories.EventRepository;
import com.events.repositories.MessageRepository;
import com.events.repositories.UserRepository;

@Service
public class AppService {
	

	@Autowired
	private UserRepository uRepository;
	
	@Autowired
	private MessageRepository mRepository;
	
	@Autowired
	private EventRepository eRepository;

	// Register a user
	public User registerUser(User user) {
        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashedPassword);
        return this.uRepository.save(user);
    }
	
	// Create an event
	public Event createEvent(Event event) {
        return this.eRepository.save(event);
    }
	
	// Create new message
	public void addCommentsToEvent(User author, Event event, String comment) {
		Message message = new Message(author, event, comment);
		this.mRepository.save(message);
    }
	
	
	// Find user by ID
	public User getUserById(Long id) {
		return this.uRepository.findById(id).orElse(null);
	}
	
	// Find user by email
	public User getUserByEmail(String email) {
		return this.uRepository.findByEmail(email).orElse(null);
	}
	
	// Find event by ID
	public Event getEventById(Long id) {
		return this.eRepository.findById(id).orElse(null);
	}
	
	// Find events in a specific state
	public List <Event> getEventByState(String state) {
		return this.eRepository.findByState(state);
	}
	
	// Find events not in a specific state
	public List <Event> getEventByStateNotIn(String state) {
		return this.eRepository.findByStateIsNot(state);
	}
	
	
	// Add user to an event
	public void addUserToEvent(User user, Event event) {
		event.getAttendees().add(user);
		this.eRepository.save(event);
	}
	
	// Remove user from an event
	public void removeUserFromEvent(User user, Event event) {
		event.getAttendees().remove(user);
		this.eRepository.save(event);
	}
	
	// Update fields from an event
	public void updateEvent(Event event) {
        this.eRepository.save(event);
    }
	

	// Deletes a question by id
	public void deleteEventById(Long id) {
		this.eRepository.deleteById(id);
	}

	// authenticate user
    public boolean authenticateUser(String email, String password) {
        // first find the user by email
        User user = this.getUserByEmail(email);
        // if we can't find it by email, return false
        if(user == null) {
            return false;
        } else {
            // if the passwords match, return true, else, return false
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
    }

}