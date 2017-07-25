<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="top-menu">
                        <ul class="nav navbar-nav pull-right">
                            <li class="dropdown dropdown-user">
                                <div class="dropdown-toggle">
                                    <img alt="" class="img-circle" src="<%  out.println(session.getAttribute( "pictureUrl" )); %>">
                                    <span class="username username-hide-on-mobile"> <% out.println(session.getAttribute( "firstName" )+" "+session.getAttribute( "lastName" )); %> </span>
                                </div>
                            </li>
                        </ul>
                    </div>