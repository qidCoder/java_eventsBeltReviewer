<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Index</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

    <script defer src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script defer src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</head>

<body>
	

        <h1>Events Belt Reviewer</h1>
        
                    <a href="/logout">Logout</a>


		<div class="ml-4">
		
			<h3>Welcome <c:out value="${user.firstName}"/>!</h3>
			<hr>

			<section class = "mt-3 mb-4">
				<h5> Here are some of the events in your state:</h5>
				<div class="row">
					<div class="col-9">
						<table class="table table-dark mt-1">
					    	<thead>
					        	<tr>
					            	<th>Name</th>
					            	<th>Date</th>
					            	<th>Location</th>
					            	<th>Host</th>
					            	<th>Action</th>
					       		</tr>
					    	</thead>
					    	<tbody>
					        	<c:forEach items="${eventsInUserState}" var="event">
					        	<tr>

					            	<td>
					            		<a href="/events/${event.id}"><c:out value="${event.name}"/></a>
					            	</td>
					            	

					            	<td>
					            		<fmt:setLocale value = "en_US" scope="session"/>
					            		<fmt:formatDate value="${event.date}" pattern="MMMM dd, yyyy"/>
					            	</td>
					            	

					            	<td><c:out value="${event.city}"/></td>

					            	<td><c:out value="${event.planner.firstName} ${event.planner.lastName}"/></td>
					            	

					            	<c:choose>
					            		
					            		<c:when test="${ event.planner.id == user.id }">
							            	<td> 
							            		<a href="/events/${event.id}/edit">Edit</a> |
							            		<form class="delete_form" action="/events/${event.id}" method="post">
													<input type="hidden" name="_method" value="delete"/>
													<button type="button" class="delete_button btn btn-link">Delete</button>
												</form>  
							            	</td>
						            	</c:when>
						            
						            	<c:otherwise>
						            		<c:choose>
					            				<c:when test="${ event.attendees.contains(user)}">
								            		<td> 
									            		<span> Joining | <a href="/events/${event.id}/attendee/cancel">Cancel</a></span>  
									            	</td>
								            	</c:when>
								            	<c:otherwise>
								            		<td> 
									            		<span> <a href="/events/${event.id}/attendee/join">Join</a></span>  
									            	</td>
								            	</c:otherwise>
							            	</c:choose>
						            	</c:otherwise>
					            	</c:choose>
					        	</tr>
					        	</c:forEach>
					    	</tbody>
						</table>
					</div>
				</div>
			</section>

			<section class = "mb-4">
				<h5> Events in other states:</h5>
				<div class="row">
					<div class="col-9">
						<table class="table table-dark mt-1">
					    	<thead>
					        	<tr>
					            	<th>Name</th>
					            	<th>Date</th>
					            	<th>Location</th>
					            	<th>Host</th>
					            	<th>Action</th>
					       		</tr>
					    	</thead>
					    	<tbody>
					        	<c:forEach items="${eventsNotInUserState}" var="event">
					        	<tr>

					            	<td>
					            		<a href="/events/${event.id}"><c:out value="${event.name}"/></a>
					            	</td>

					            	<td>
					            		<fmt:setLocale value = "en_US" scope="session"/>
					            		<fmt:formatDate value="${event.date}" pattern="MMMM dd, yyyy"/>
					            	</td>

					            	<td><c:out value="${event.city}"/></td>
					            	

					            	<td><c:out value="${event.planner.firstName} ${event.planner.lastName}"/></td>
					            	

					            	<c:choose>
					            		
					            		<c:when test="${event.planner.id == user.id}">
							            	<td> 
							            		<a href="/events/${event.id}/edit">Edit</a> |
							            		<form class="delete_form" action="/events/${ event.id }" method="post">
													<input type="hidden" name="_method" value="delete" />
													<button type="button" class="delete_button btn btn-link">Delete</button>
												</form>  
							            	</td>
						            	</c:when>
						            
						            	<c:otherwise>
						            		<c:choose>
					            				<c:when test="${event.attendees.contains(user)}">
								            		<td> 
									            		<span> Joining | <a href="/events/${event.id}/attendee/cancel">Cancel</a></span>  
									            	</td>
								            	</c:when>
								            	<c:otherwise>
								            		<td> 
									            		<span> <a href="/events/${event.id}/attendee/join">Join</a></span>  
									            	</td>
								            	</c:otherwise>
							            	</c:choose>
						            	</c:otherwise>
					            	</c:choose>
					        	</tr>
					        	</c:forEach>
					    	</tbody>
						</table>
					</div>
				</div>
			
			</section>
			

			
			<hr>
			<section class="ml-3" >
		
				<h3 class="mb-4"> Create an Event</h3>
				<div class="row">
					<div class="col-6">
						<form:form action="/events/new" method="POST" modelAttribute="event">

							<form:hidden value="${user.id}" path="planner"/>

				        	<div class="form-group row">
					        	<form:label class="col-2 col-form-label" path="name">Name</form:label>
					       		 <div class="col-8">
					        		<form:input class="form-control" type="text" path="name"/>
					        		<form:errors class="small" path="name"/>
					        	</div>
					    	</div>
					    	

					    	<div class="form-group row">
					        	<form:label class="col-2 col-form-label" path="date">Date</form:label>
					       		 <div class="col-8">
					        		<form:input class="form-control" type="date" path="date"/>
					        		<form:errors class="small" path="date"/>
					        	</div>
					    	</div>
					    	

					    	<div class ="row ">
					    	
						    	<div class ="col-6">
						        	<div class="form-group row">
							        	<form:label class="col-4 col-form-label" path="city">City</form:label>
							       		 <div class="col-8">
							        		<form:input class="form-control" type="text" path="city"/>
							        		<form:errors class="small" path="city"/>
							        	</div>
							    	</div>
						    	</div>
						    	
						    	<div class ="col-4">
							    	<div class="form-group row">
							    		<form:label class="col-4 col-form-label" path="state">State</form:label>
							       		 <div class="col-8">
							        		<form:select class="form-control" type="text" path="state">
							        			<c:forEach items="${states}" var="state">
													<option value="${state}">${state}</option>
												</c:forEach>
											</form:select>
							        		<form:errors class="small" path="state"/>
							        	</div>
							    	</div>
						    	</div>
					    	</div>
					    	

					    	<div class="form-group row">
				    			<div class="col-3 offset-2">
				    				<input class = "btn btn-success" type="submit" value="Add Event"/>
				    			</div>	
				    		</div>
					    	
					    </form:form>
			    	
			    	</div>
			    </div>
			</section>
			<hr>
			
		</div>

	
</body>
</html>