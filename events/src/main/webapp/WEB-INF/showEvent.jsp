<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page isErrorPage="true" %>  

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
	

        <a class="navbar-brand text-decoration-none" href="#">Events Belt Reviewer</a>


                    <a class="nav-link active" href="/events">Dashboard</a>

                    <a class="nav-link active" href="/logout">Logout</a>

		
		<h3><c:out value="${event.name}"/></h3>
		<hr>
		
		<section class="mt-3 ml-3" >
			<div class="row justify-content-around">
		
				<div class="col-5">
		
					<h5 class="mb-1"> Event Details</h5>
					<p>Host: <c:out value="${event.planner.firstName} ${event.planner.lastName}"/></p>			            		
					<p>Date:
						<fmt:setLocale value = "en_US" scope="session"/>
						<fmt:formatDate value="${event.date}" pattern="MMMM dd, yyyy"/>
					</p>
					<p>Location: <c:out value="${event.city}, ${event.state}"/></p>
					<p>People who are attending this event: <c:out value="${event.attendees.size()}"/></p>

					<h5 class="mt-4 mb-2"> People Attending</h5>
					<table class="table table-dark table-sm mt-1 p-1">
				    	<thead>
				        	<tr>
				            	<th class="pl-3">Name</th>
								<th>Location</th>
				           	</tr>
				    	</thead>
				    	<tbody>
				        	<c:forEach items="${event.attendees}" var="attendee">
					        	<tr>
				
					            	<td class="pl-3"><c:out value="${attendee.firstName} ${attendee.lastName}"/></td>
					            	<!-- Location Field -->
					            	<td><c:out value="${attendee.city}"/></td>
					        	</tr>
				        	</c:forEach>
				    	</tbody>
					</table>
				</div>
	
				<div class="col-5">
		
			
					<div>
						<h5 class="mb-1"> Message Wall</h5>
						<div id="messageBox" class="px-2 py-3">
							<c:forEach items="${event.messages}" var="comment">
						        <p><c:out value="${comment.author.firstName} ${comment.author.lastName} says: ${comment.content}"/></p>
						        <p> --------------------- </p>
					        </c:forEach>
						</div>	
					</div>            		
					
		
					<div>
						<h5 class="mt-4 mb-2"> Add Comment</h5>
						<form action="/events/${event.id}/comment" method="POST">
							<!-- Comment Field -->
				        	<div class="form-group row">
					        	<div class="col-10">
					        		<textarea class="form-control" rows="5" name="comment"></textarea>
					        		<span id="errors">${ error }</span>
					        	</div>
					    	</div>
					    	
		
					    	<div class="form-group row">
				    			<div class="col-3 offset-7">
				    				<input class = "btn btn-success" type="submit" value="Comment"/>
				    			</div>	
				    		</div>
						</form>
					</div>
					
				</div>
			</div>
		
		</section>
		

	
</body>
</html>