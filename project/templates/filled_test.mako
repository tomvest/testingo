<%inherit file="default.mako" />
<%block name="title">${incomplete_test.test.name}</%block>
<%block name="page_content">
<script src="${request.static_path('project:static/js/edit.js')}"></script>
<div class="page-header">
    <h1>${incomplete_test.test.name}</h1>
</div>
    <div class="container">
        <div class="control-group">
            <div class="controls">
                <p>${incomplete_test.test.description}</p>
            </div>

            <h2>Otázky</h2>

            % if len(incomplete_test.test.questions) is 0:
                    <span> Test neobsahuje žiadne otázky a ani odpovede </span>
            % else:
                % for question in questions_and_answers:
                % if question[0].qtype == 'S':

                        <div class="panel">
                            <div class="panel-heading">
                                	% if question[1][0].correct == 1:
                                	<h3 class="panel-title">Otázka č.${question[0].number}
                                    <span class="badge pull-right">
                                        ${question[0].points}b
                                    </span>
                                  </h3>
                                  %else:
                                  <h3 class="panel-title">Otázka č.${question[0].number}
                                  <span class="badge pull-right">
                                        ${0}b
                                  </span>
                                  </h3>
                                	%endif
                                </a>
                        	</div>
                            <p><strong>Znenie otázky <br></strong>${question[0].text}</p>
                            	% if question[1][0].correct == 1:
                                    <p class="text-success">
                                    <strong>Správna odpoveď uźívateľa:</strong>
                                        ${question[1][0].text} <br>
                                    </p>

                                %else:
                                    <p class="text-danger">
                                    <strong>Nesprávna odpoveď uźívateľa:</strong>
                                        ${question[1][0].text} <br>
                                    </p>

                            	% endif

                        </div>
                 % elif question[0].qtype == 'C':

                        <div class="panel">
                            <div class="panel-heading">

                                  <h3 class="panel-title">Otázka č.${question[0].number}</h3>
3>
                        	</div>
                            <p><strong>Znenie otázky <br></strong>${question[0].text}</p>
                                % for ans in question[1]:

                                    % if ans.correct == 1:
                                        %if int(ans.text) == 0:
                                            <span><p class="text-success"><input type="checkbox" disabled="disabled">
                                              ${ans.answer.text}</p></span>
                                        %else:

                                             <span><p class="text-success"><input type="checkbox" disabled="disabled" checked="checked">
                                             ${ans.answer.text}</p></span>
                                        %endif

                                    %else:
                                        %if int(ans.text) == 0:
                                           <span>  <p class="text-danger"><input type="checkbox" disabled="disabled">
                                          ${ans.answer.text}</p></span>

                                        %else:

                                             <span><p class="text-danger"><input type="checkbox" disabled="disabled" checked="checked">
                                             ${ans.answer.text}</p></span>
                                        %endif

                            	    % endif
                                % endfor

                        </div>
                       % endif
                % endfor
            % endif
        </div>
    </div>
</%block>
