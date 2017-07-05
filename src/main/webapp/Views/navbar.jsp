   

<%@ page contentType="text/html; charset=UTF-8" %>
<nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
            <a class="navbar-brand" href="#">Hoşgeldiniz <% out.println(session.getAttribute( "userName" )); %></a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="createForm.jsp">Yeni İlan Ekle</a></li>
            <li><a href="editForms.jsp">İlanları Düzenle</a></li>
            <li><a href="Actions/logout.jsp">Çıkış Yap</a></li>
          </ul>
        </div>
      </div>
    </nav>