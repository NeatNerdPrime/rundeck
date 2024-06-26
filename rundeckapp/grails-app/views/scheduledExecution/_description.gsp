%{--
  - Copyright 2014 SimplifyOps Inc, <http://simplifyops.com>
  -
  - Licensed under the Apache License, Version 2.0 (the "License");
  - you may not use this file except in compliance with the License.
  - You may obtain a copy of the License at
  -
  -     http://www.apache.org/licenses/LICENSE-2.0
  -
  - Unless required by applicable law or agreed to in writing, software
  - distributed under the License is distributed on an "AS IS" BASIS,
  - WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  - See the License for the specific language governing permissions and
  - limitations under the License.
  --}%

<g:set var="allowHTML"
       value="${!(cfg.getString(config: "gui.job.description.disableHTML") in [true,'true'])}"/>
<g:set var="firstline" value="${g.textFirstLine(text: description)}"/>
<g:if test="${allowHTML && !firstLineOnly}">
    <g:set var="remainingLine" value="${g.textRemainingLines(text: description)}"/>
    <g:if test="${cutoffMarker}">
        <g:set var="remainingLine" value="${g.textBeforeLine(text: remainingLine, marker:cutoffMarker)}"/>
    </g:if>

    <g:if test="${remainingLine?.trim()}">
        <g:set var="replTokens" value="${[:]}"/>
        <g:if test="${service && name}">
            <g:set var="pluginBaseUrl" value="${g.createLink(
                    controller: 'plugin',
                    action: 'pluginFile',
                    params: [service: service, name: name]
            )}"/>
            <g:set var="replTokens" value="${['plugin.url':pluginBaseUrl]}"/>
        </g:if>
        <g:if test="${mode=='collapsed' || mode=='expanded'}">
            <details class="more-info" ${mode=='expanded'?'open':''}>
                <summary>
                    <span class="${enc(attr: textCss ?: '')}"><g:enc>${firstline}</g:enc></span>
                    <span class="btn-link btn-xs more-indicator-verbiage">
                        ${moreText?:message(code: "more", default: "More")}
                    </span>
                    <span class="btn-link btn-xs less-indicator-verbiage">
                        <g:message code="less"  default="Less"/>
                    </span>
                </summary>
                <div class="${enc(attr: markdownCss ?: '')} more-info-content" >
                    <g:markdown><g:autoLink jobLinkId="${jobLinkId}" tokens="${replTokens}">${remainingLine}</g:autoLink></g:markdown>
                </div>
            </details>

        </g:if>
        <g:elseif test="${mode!='hidden'}">
            <span class="${enc(attr: markdownCss ?: '')}">
                <g:markdown><g:autoLink jobLinkId="${jobLinkId}" tokens="${replTokens}">${remainingLine}</g:autoLink></g:markdown>
            </span>
        </g:elseif>
    </g:if>
    <g:else>
        <span class="${enc(attr: textCss ?: '')}"><g:enc>${firstline}</g:enc></span>
    </g:else>
</g:if>
<g:else>
    <span class="${enc(attr:textCss?:'')}">
        <g:enc>${firstline}</g:enc>
    </span>
</g:else>
