let home request =
  <html>
  <body>
    <%s! Dream.form_tag ~action:"/" ~enctype:`Multipart_form_data request %>
      <input name="text"><br>
      <input name="files" type="file" multiple><br>
      <button>Submit!</button>
    </form>
  </body>
  </html>

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.memory_sessions
  @@ Dream.router [

    Dream.get  "/" (fun request ->
      Dream.html (home request));

    Dream.post "/" (fun request ->
      let%lwt body = Dream.body request in
      Dream.respond
        ~headers:["Content-Type", "text/plain"]
        body);

  ]
  @@ Dream.not_found
