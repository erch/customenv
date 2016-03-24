


<!DOCTYPE html>
<html>
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# githubog: http://ogp.me/ns/fb/githubog#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>chef-mode/chef-mode.el at master · mpasternacki/chef-mode · GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png" />
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png" />
    <link rel="logo" type="image/svg" href="https://github-media-downloads.s3.amazonaws.com/github-logo.svg" />
    <meta property="og:image" content="https://github.global.ssl.fastly.net/images/modules/logos_page/Octocat.png">
    <meta name="hostname" content="github-fe115-cp1-prd.iad.github.net">
    <meta name="ruby" content="ruby 2.0.0p247-github5 (2013-06-27) [x86_64-linux]">
    <link rel="assets" href="https://github.global.ssl.fastly.net/">
    <link rel="xhr-socket" href="/_sockets" />
    
    


    <meta name="msapplication-TileImage" content="/windows-tile.png" />
    <meta name="msapplication-TileColor" content="#ffffff" />
    <meta name="selected-link" value="repo_source" data-pjax-transient />
    <meta content="collector.githubapp.com" name="octolytics-host" /><meta content="github" name="octolytics-app-id" /><meta content="5e7101f7-81c3-489d-9c3c-9b8022bb4c61" name="octolytics-dimension-request_id" />
    

    
    
    <link rel="icon" type="image/x-icon" href="/favicon.ico" />

    <meta content="authenticity_token" name="csrf-param" />
<meta content="ahEEb7XPBJzkEIC2nYCcK8EPdqmwggvik4aL0hfd2s0=" name="csrf-token" />

    <link href="https://github.global.ssl.fastly.net/assets/github-1571e8531c9d48a5e17e976e56fb9f29b8e41cf2.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://github.global.ssl.fastly.net/assets/github2-4aac1f1fa7a38c2fbe63b6951d4f85decbe92c03.css" media="all" rel="stylesheet" type="text/css" />
    

    

      <script src="https://github.global.ssl.fastly.net/assets/frameworks-f86a2975a82dceee28e5afe598d1ebbfd7109d79.js" type="text/javascript"></script>
      <script src="https://github.global.ssl.fastly.net/assets/github-a4a7207e7dacc57635e1d9db14d6becb2053fc5f.js" type="text/javascript"></script>
      
      <meta http-equiv="x-pjax-version" content="f2d29d78ad073bd72577c94b9109a724">

        <link data-pjax-transient rel='permalink' href='/mpasternacki/chef-mode/blob/c333dd3f9229c4f35fe8c4495b21049ba730cc42/chef-mode.el'>
  <meta property="og:title" content="chef-mode"/>
  <meta property="og:type" content="githubog:gitrepository"/>
  <meta property="og:url" content="https://github.com/mpasternacki/chef-mode"/>
  <meta property="og:image" content="https://github.global.ssl.fastly.net/images/gravatars/gravatar-user-420.png"/>
  <meta property="og:site_name" content="GitHub"/>
  <meta property="og:description" content="chef-mode - Emacs mode to edit Chef repositories"/>

  <meta name="description" content="chef-mode - Emacs mode to edit Chef repositories" />

  <meta content="56355" name="octolytics-dimension-user_id" /><meta content="mpasternacki" name="octolytics-dimension-user_login" /><meta content="2285514" name="octolytics-dimension-repository_id" /><meta content="mpasternacki/chef-mode" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="2285514" name="octolytics-dimension-repository_network_root_id" /><meta content="mpasternacki/chef-mode" name="octolytics-dimension-repository_network_root_nwo" />
  <link href="https://github.com/mpasternacki/chef-mode/commits/master.atom" rel="alternate" title="Recent Commits to chef-mode:master" type="application/atom+xml" />

  </head>


  <body class="logged_out  env-production linux vis-public page-blob">
    <div class="wrapper">
      
      
      


      
      <div class="header header-logged-out">
  <div class="container clearfix">

    <a class="header-logo-wordmark" href="https://github.com/">
      <span class="mega-octicon octicon-logo-github"></span>
    </a>

    <div class="header-actions">
        <a class="button primary" href="/signup">Sign up</a>
      <a class="button" href="/login?return_to=%2Fmpasternacki%2Fchef-mode%2Fblob%2Fmaster%2Fchef-mode.el">Sign in</a>
    </div>

    <div class="command-bar js-command-bar  in-repository">

      <ul class="top-nav">
          <li class="explore"><a href="/explore">Explore</a></li>
        <li class="features"><a href="/features">Features</a></li>
          <li class="enterprise"><a href="https://enterprise.github.com/">Enterprise</a></li>
          <li class="blog"><a href="/blog">Blog</a></li>
      </ul>
        <form accept-charset="UTF-8" action="/search" class="command-bar-form" id="top_search_form" method="get">

<input type="text" data-hotkey="/ s" name="q" id="js-command-bar-field" placeholder="Search or type a command" tabindex="1" autocapitalize="off"
    
    
      data-repo="mpasternacki/chef-mode"
      data-branch="master"
      data-sha="ec5de929ed52d76c674ea6643c1d0c6cdc0d15e6"
  >

    <input type="hidden" name="nwo" value="mpasternacki/chef-mode" />

    <div class="select-menu js-menu-container js-select-menu search-context-select-menu">
      <span class="minibutton select-menu-button js-menu-target">
        <span class="js-select-button">This repository</span>
      </span>

      <div class="select-menu-modal-holder js-menu-content js-navigation-container">
        <div class="select-menu-modal">

          <div class="select-menu-item js-navigation-item js-this-repository-navigation-item selected">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" class="js-search-this-repository" name="search_target" value="repository" checked="checked" />
            <div class="select-menu-item-text js-select-button-text">This repository</div>
          </div> <!-- /.select-menu-item -->

          <div class="select-menu-item js-navigation-item js-all-repositories-navigation-item">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" name="search_target" value="global" />
            <div class="select-menu-item-text js-select-button-text">All repositories</div>
          </div> <!-- /.select-menu-item -->

        </div>
      </div>
    </div>

  <span class="octicon help tooltipped downwards" title="Show command bar help">
    <span class="octicon octicon-question"></span>
  </span>


  <input type="hidden" name="ref" value="cmdform">

</form>
    </div>

  </div>
</div>


      


          <div class="site" itemscope itemtype="http://schema.org/WebPage">
    
    <div class="pagehead repohead instapaper_ignore readability-menu">
      <div class="container">
        

<ul class="pagehead-actions">


  <li>
  <a href="/login?return_to=%2Fmpasternacki%2Fchef-mode"
  class="minibutton with-count js-toggler-target star-button entice tooltipped upwards"
  title="You must be signed in to use this feature" rel="nofollow">
  <span class="octicon octicon-star"></span>Star
</a>
<a class="social-count js-social-count" href="/mpasternacki/chef-mode/stargazers">
  13
</a>

  </li>

    <li>
      <a href="/login?return_to=%2Fmpasternacki%2Fchef-mode"
        class="minibutton with-count js-toggler-target fork-button entice tooltipped upwards"
        title="You must be signed in to fork a repository" rel="nofollow">
        <span class="octicon octicon-git-branch"></span>Fork
      </a>
      <a href="/mpasternacki/chef-mode/network" class="social-count">
        11
      </a>
    </li>
</ul>

        <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
          <span class="repo-label"><span>public</span></span>
          <span class="mega-octicon octicon-repo"></span>
          <span class="author">
            <a href="/mpasternacki" class="url fn" itemprop="url" rel="author"><span itemprop="title">mpasternacki</span></a></span
          ><span class="repohead-name-divider">/</span><strong
          ><a href="/mpasternacki/chef-mode" class="js-current-repository js-repo-home-link">chef-mode</a></strong>

          <span class="page-context-loader">
            <img alt="Octocat-spinner-32" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
          </span>

        </h1>
      </div><!-- /.container -->
    </div><!-- /.repohead -->

    <div class="container">

      <div class="repository-with-sidebar repo-container ">

        <div class="repository-sidebar">
            

<div class="repo-nav repo-nav-full js-repository-container-pjax js-octicon-loaders">
  <div class="repo-nav-contents">
    <ul class="repo-menu">
      <li class="tooltipped leftwards" title="Code">
        <a href="/mpasternacki/chef-mode" aria-label="Code" class="js-selected-navigation-item selected" data-gotokey="c" data-pjax="true" data-selected-links="repo_source repo_downloads repo_commits repo_tags repo_branches /mpasternacki/chef-mode">
          <span class="octicon octicon-code"></span> <span class="full-word">Code</span>
          <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

        <li class="tooltipped leftwards" title="Issues">
          <a href="/mpasternacki/chef-mode/issues" aria-label="Issues" class="js-selected-navigation-item js-disable-pjax" data-gotokey="i" data-selected-links="repo_issues /mpasternacki/chef-mode/issues">
            <span class="octicon octicon-issue-opened"></span> <span class="full-word">Issues</span>
            <span class='counter'>1</span>
            <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>

      <li class="tooltipped leftwards" title="Pull Requests"><a href="/mpasternacki/chef-mode/pulls" aria-label="Pull Requests" class="js-selected-navigation-item js-disable-pjax" data-gotokey="p" data-selected-links="repo_pulls /mpasternacki/chef-mode/pulls">
            <span class="octicon octicon-git-pull-request"></span> <span class="full-word">Pull Requests</span>
            <span class='counter'>1</span>
            <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>


    </ul>
    <div class="repo-menu-separator"></div>
    <ul class="repo-menu">

      <li class="tooltipped leftwards" title="Pulse">
        <a href="/mpasternacki/chef-mode/pulse" aria-label="Pulse" class="js-selected-navigation-item " data-pjax="true" data-selected-links="pulse /mpasternacki/chef-mode/pulse">
          <span class="octicon octicon-pulse"></span> <span class="full-word">Pulse</span>
          <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped leftwards" title="Graphs">
        <a href="/mpasternacki/chef-mode/graphs" aria-label="Graphs" class="js-selected-navigation-item " data-pjax="true" data-selected-links="repo_graphs repo_contributors /mpasternacki/chef-mode/graphs">
          <span class="octicon octicon-graph"></span> <span class="full-word">Graphs</span>
          <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped leftwards" title="Network">
        <a href="/mpasternacki/chef-mode/network" aria-label="Network" class="js-selected-navigation-item js-disable-pjax" data-selected-links="repo_network /mpasternacki/chef-mode/network">
          <span class="octicon octicon-git-branch"></span> <span class="full-word">Network</span>
          <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>
    </ul>


  </div>
</div>

            <div class="only-with-full-nav">
              

  

<div class="clone-url open"
  data-protocol-type="http"
  data-url="/users/set_protocol?protocol_selector=http&amp;protocol_type=clone">
  <h3><strong>HTTPS</strong> clone URL</h3>
  <div class="clone-url-box">
    <input type="text" class="clone js-url-field"
           value="https://github.com/mpasternacki/chef-mode.git" readonly="readonly">

    <span class="js-zeroclipboard url-box-clippy minibutton zeroclipboard-button" data-clipboard-text="https://github.com/mpasternacki/chef-mode.git" data-copied-hint="copied!" title="copy to clipboard"><span class="octicon octicon-clippy"></span></span>
  </div>
</div>

  

<div class="clone-url "
  data-protocol-type="subversion"
  data-url="/users/set_protocol?protocol_selector=subversion&amp;protocol_type=clone">
  <h3><strong>Subversion</strong> checkout URL</h3>
  <div class="clone-url-box">
    <input type="text" class="clone js-url-field"
           value="https://github.com/mpasternacki/chef-mode" readonly="readonly">

    <span class="js-zeroclipboard url-box-clippy minibutton zeroclipboard-button" data-clipboard-text="https://github.com/mpasternacki/chef-mode" data-copied-hint="copied!" title="copy to clipboard"><span class="octicon octicon-clippy"></span></span>
  </div>
</div>


<p class="clone-options">You can clone with
      <a href="#" class="js-clone-selector" data-protocol="http">HTTPS</a>,
      or <a href="#" class="js-clone-selector" data-protocol="subversion">Subversion</a>.
  <span class="octicon help tooltipped upwards" title="Get help on which URL is right for you.">
    <a href="https://help.github.com/articles/which-remote-url-should-i-use">
    <span class="octicon octicon-question"></span>
    </a>
  </span>
</p>



                <a href="/mpasternacki/chef-mode/archive/master.zip"
                   class="minibutton sidebar-button"
                   title="Download this repository as a zip file"
                   rel="nofollow">
                  <span class="octicon octicon-cloud-download"></span>
                  Download ZIP
                </a>
            </div>
        </div><!-- /.repository-sidebar -->

        <div id="js-repo-pjax-container" class="repository-content context-loader-container" data-pjax-container>
          


<!-- blob contrib key: blob_contributors:v21:21c25439d10a2cb71e7010b30a3a2c9c -->
<!-- blob contrib frag key: views10/v8/blob_contributors:v21:21c25439d10a2cb71e7010b30a3a2c9c -->

<p title="This is a placeholder element" class="js-history-link-replace hidden"></p>

<a href="/mpasternacki/chef-mode/find/master" data-pjax data-hotkey="t" style="display:none">Show File Finder</a>

<div class="file-navigation">
  


<div class="select-menu js-menu-container js-select-menu" >
  <span class="minibutton select-menu-button js-menu-target" data-hotkey="w"
    data-master-branch="master"
    data-ref="master"
    role="button" aria-label="Switch branches or tags" tabindex="0">
    <span class="octicon octicon-git-branch"></span>
    <i>branch:</i>
    <span class="js-select-button">master</span>
  </span>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax>

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <span class="select-menu-title">Switch branches/tags</span>
        <span class="octicon octicon-remove-close js-menu-close"></span>
      </div> <!-- /.select-menu-header -->

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Filter branches/tags" id="context-commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
            </li>
          </ul>
        </div><!-- /.select-menu-tabs -->
      </div><!-- /.select-menu-filters -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item selected">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/mpasternacki/chef-mode/blob/master/chef-mode.el" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="master" data-skip-pjax="true" rel="nofollow" title="master">master</a>
            </div> <!-- /.select-menu-item -->
        </div>

          <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

    </div> <!-- /.select-menu-modal -->
  </div> <!-- /.select-menu-modal-holder -->
</div> <!-- /.select-menu -->

  <div class="breadcrumb">
    <span class='repo-root js-repo-root'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/mpasternacki/chef-mode" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">chef-mode</span></a></span></span><span class="separator"> / </span><strong class="final-path">chef-mode.el</strong> <span class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="chef-mode.el" data-copied-hint="copied!" title="copy to clipboard"><span class="octicon octicon-clippy"></span></span>
  </div>
</div>


  
  <div class="commit file-history-tease">
    <img class="main-avatar" height="24" src="https://0.gravatar.com/avatar/1bd1f0ff92bed69bfb53eefa9fd606f8?d=https%3A%2F%2Fidenticons.github.com%2Faff2f2fc36ca7a0ad068477106e12ba3.png&amp;s=140" width="24" />
    <span class="author"><a href="/mpasternacki" rel="author">mpasternacki</a></span>
    <time class="js-relative-date" datetime="2011-11-21T07:00:10-08:00" title="2011-11-21 07:00:10">November 21, 2011</time>
    <div class="commit-title">
        <a href="/mpasternacki/chef-mode/commit/c333dd3f9229c4f35fe8c4495b21049ba730cc42" class="message" data-pjax="true" title="More verbose command">More verbose command</a>
    </div>

    <div class="participation">
      <p class="quickstat"><a href="#blob_contributors_box" rel="facebox"><strong>2</strong> contributors</a></p>
          <a class="avatar tooltipped downwards" title="mpasternacki" href="/mpasternacki/chef-mode/commits/master/chef-mode.el?author=mpasternacki"><img height="20" src="https://0.gravatar.com/avatar/1bd1f0ff92bed69bfb53eefa9fd606f8?d=https%3A%2F%2Fidenticons.github.com%2Faff2f2fc36ca7a0ad068477106e12ba3.png&amp;s=140" width="20" /></a>
    <a class="avatar tooltipped downwards" title="zev" href="/mpasternacki/chef-mode/commits/master/chef-mode.el?author=zev"><img height="20" src="https://0.gravatar.com/avatar/1c77ad9f35746369dd1f4dd69b9f8b18?d=https%3A%2F%2Fidenticons.github.com%2F30a1afeb8b42ea58ee31af1883eac32c.png&amp;s=140" width="20" /></a>


    </div>
    <div id="blob_contributors_box" style="display:none">
      <h2 class="facebox-header">Users who have contributed to this file</h2>
      <ul class="facebox-user-list">
        <li class="facebox-user-list-item">
          <img height="24" src="https://0.gravatar.com/avatar/1bd1f0ff92bed69bfb53eefa9fd606f8?d=https%3A%2F%2Fidenticons.github.com%2Faff2f2fc36ca7a0ad068477106e12ba3.png&amp;s=140" width="24" />
          <a href="/mpasternacki">mpasternacki</a>
        </li>
        <li class="facebox-user-list-item">
          <img height="24" src="https://0.gravatar.com/avatar/1c77ad9f35746369dd1f4dd69b9f8b18?d=https%3A%2F%2Fidenticons.github.com%2F30a1afeb8b42ea58ee31af1883eac32c.png&amp;s=140" width="24" />
          <a href="/zev">zev</a>
        </li>
      </ul>
    </div>
  </div>


<div id="files" class="bubble">
  <div class="file">
    <div class="meta">
      <div class="info">
        <span class="icon"><b class="octicon octicon-file-text"></b></span>
        <span class="mode" title="File Mode">file</span>
          <span>240 lines (203 sloc)</span>
        <span>9.116 kb</span>
      </div>
      <div class="actions">
        <div class="button-group">
              <a class="minibutton disabled js-entice" href=""
                 data-entice="You must be signed in to make or propose changes">Edit</a>
          <a href="/mpasternacki/chef-mode/raw/master/chef-mode.el" class="button minibutton " id="raw-url">Raw</a>
            <a href="/mpasternacki/chef-mode/blame/master/chef-mode.el" class="button minibutton ">Blame</a>
          <a href="/mpasternacki/chef-mode/commits/master/chef-mode.el" class="button minibutton " rel="nofollow">History</a>
        </div><!-- /.button-group -->
            <a class="minibutton danger empty-icon js-entice" href=""
               data-entice="You must be signed in and on a branch to make or propose changes">
            Delete
          </a>
      </div><!-- /.actions -->

    </div>
        <div class="blob-wrapper data type-emacs-lisp js-blob-data">
        <table class="file-code file-diff">
          <tr class="file-code-line">
            <td class="blob-line-nums">
              <span id="L1" rel="#L1">1</span>
<span id="L2" rel="#L2">2</span>
<span id="L3" rel="#L3">3</span>
<span id="L4" rel="#L4">4</span>
<span id="L5" rel="#L5">5</span>
<span id="L6" rel="#L6">6</span>
<span id="L7" rel="#L7">7</span>
<span id="L8" rel="#L8">8</span>
<span id="L9" rel="#L9">9</span>
<span id="L10" rel="#L10">10</span>
<span id="L11" rel="#L11">11</span>
<span id="L12" rel="#L12">12</span>
<span id="L13" rel="#L13">13</span>
<span id="L14" rel="#L14">14</span>
<span id="L15" rel="#L15">15</span>
<span id="L16" rel="#L16">16</span>
<span id="L17" rel="#L17">17</span>
<span id="L18" rel="#L18">18</span>
<span id="L19" rel="#L19">19</span>
<span id="L20" rel="#L20">20</span>
<span id="L21" rel="#L21">21</span>
<span id="L22" rel="#L22">22</span>
<span id="L23" rel="#L23">23</span>
<span id="L24" rel="#L24">24</span>
<span id="L25" rel="#L25">25</span>
<span id="L26" rel="#L26">26</span>
<span id="L27" rel="#L27">27</span>
<span id="L28" rel="#L28">28</span>
<span id="L29" rel="#L29">29</span>
<span id="L30" rel="#L30">30</span>
<span id="L31" rel="#L31">31</span>
<span id="L32" rel="#L32">32</span>
<span id="L33" rel="#L33">33</span>
<span id="L34" rel="#L34">34</span>
<span id="L35" rel="#L35">35</span>
<span id="L36" rel="#L36">36</span>
<span id="L37" rel="#L37">37</span>
<span id="L38" rel="#L38">38</span>
<span id="L39" rel="#L39">39</span>
<span id="L40" rel="#L40">40</span>
<span id="L41" rel="#L41">41</span>
<span id="L42" rel="#L42">42</span>
<span id="L43" rel="#L43">43</span>
<span id="L44" rel="#L44">44</span>
<span id="L45" rel="#L45">45</span>
<span id="L46" rel="#L46">46</span>
<span id="L47" rel="#L47">47</span>
<span id="L48" rel="#L48">48</span>
<span id="L49" rel="#L49">49</span>
<span id="L50" rel="#L50">50</span>
<span id="L51" rel="#L51">51</span>
<span id="L52" rel="#L52">52</span>
<span id="L53" rel="#L53">53</span>
<span id="L54" rel="#L54">54</span>
<span id="L55" rel="#L55">55</span>
<span id="L56" rel="#L56">56</span>
<span id="L57" rel="#L57">57</span>
<span id="L58" rel="#L58">58</span>
<span id="L59" rel="#L59">59</span>
<span id="L60" rel="#L60">60</span>
<span id="L61" rel="#L61">61</span>
<span id="L62" rel="#L62">62</span>
<span id="L63" rel="#L63">63</span>
<span id="L64" rel="#L64">64</span>
<span id="L65" rel="#L65">65</span>
<span id="L66" rel="#L66">66</span>
<span id="L67" rel="#L67">67</span>
<span id="L68" rel="#L68">68</span>
<span id="L69" rel="#L69">69</span>
<span id="L70" rel="#L70">70</span>
<span id="L71" rel="#L71">71</span>
<span id="L72" rel="#L72">72</span>
<span id="L73" rel="#L73">73</span>
<span id="L74" rel="#L74">74</span>
<span id="L75" rel="#L75">75</span>
<span id="L76" rel="#L76">76</span>
<span id="L77" rel="#L77">77</span>
<span id="L78" rel="#L78">78</span>
<span id="L79" rel="#L79">79</span>
<span id="L80" rel="#L80">80</span>
<span id="L81" rel="#L81">81</span>
<span id="L82" rel="#L82">82</span>
<span id="L83" rel="#L83">83</span>
<span id="L84" rel="#L84">84</span>
<span id="L85" rel="#L85">85</span>
<span id="L86" rel="#L86">86</span>
<span id="L87" rel="#L87">87</span>
<span id="L88" rel="#L88">88</span>
<span id="L89" rel="#L89">89</span>
<span id="L90" rel="#L90">90</span>
<span id="L91" rel="#L91">91</span>
<span id="L92" rel="#L92">92</span>
<span id="L93" rel="#L93">93</span>
<span id="L94" rel="#L94">94</span>
<span id="L95" rel="#L95">95</span>
<span id="L96" rel="#L96">96</span>
<span id="L97" rel="#L97">97</span>
<span id="L98" rel="#L98">98</span>
<span id="L99" rel="#L99">99</span>
<span id="L100" rel="#L100">100</span>
<span id="L101" rel="#L101">101</span>
<span id="L102" rel="#L102">102</span>
<span id="L103" rel="#L103">103</span>
<span id="L104" rel="#L104">104</span>
<span id="L105" rel="#L105">105</span>
<span id="L106" rel="#L106">106</span>
<span id="L107" rel="#L107">107</span>
<span id="L108" rel="#L108">108</span>
<span id="L109" rel="#L109">109</span>
<span id="L110" rel="#L110">110</span>
<span id="L111" rel="#L111">111</span>
<span id="L112" rel="#L112">112</span>
<span id="L113" rel="#L113">113</span>
<span id="L114" rel="#L114">114</span>
<span id="L115" rel="#L115">115</span>
<span id="L116" rel="#L116">116</span>
<span id="L117" rel="#L117">117</span>
<span id="L118" rel="#L118">118</span>
<span id="L119" rel="#L119">119</span>
<span id="L120" rel="#L120">120</span>
<span id="L121" rel="#L121">121</span>
<span id="L122" rel="#L122">122</span>
<span id="L123" rel="#L123">123</span>
<span id="L124" rel="#L124">124</span>
<span id="L125" rel="#L125">125</span>
<span id="L126" rel="#L126">126</span>
<span id="L127" rel="#L127">127</span>
<span id="L128" rel="#L128">128</span>
<span id="L129" rel="#L129">129</span>
<span id="L130" rel="#L130">130</span>
<span id="L131" rel="#L131">131</span>
<span id="L132" rel="#L132">132</span>
<span id="L133" rel="#L133">133</span>
<span id="L134" rel="#L134">134</span>
<span id="L135" rel="#L135">135</span>
<span id="L136" rel="#L136">136</span>
<span id="L137" rel="#L137">137</span>
<span id="L138" rel="#L138">138</span>
<span id="L139" rel="#L139">139</span>
<span id="L140" rel="#L140">140</span>
<span id="L141" rel="#L141">141</span>
<span id="L142" rel="#L142">142</span>
<span id="L143" rel="#L143">143</span>
<span id="L144" rel="#L144">144</span>
<span id="L145" rel="#L145">145</span>
<span id="L146" rel="#L146">146</span>
<span id="L147" rel="#L147">147</span>
<span id="L148" rel="#L148">148</span>
<span id="L149" rel="#L149">149</span>
<span id="L150" rel="#L150">150</span>
<span id="L151" rel="#L151">151</span>
<span id="L152" rel="#L152">152</span>
<span id="L153" rel="#L153">153</span>
<span id="L154" rel="#L154">154</span>
<span id="L155" rel="#L155">155</span>
<span id="L156" rel="#L156">156</span>
<span id="L157" rel="#L157">157</span>
<span id="L158" rel="#L158">158</span>
<span id="L159" rel="#L159">159</span>
<span id="L160" rel="#L160">160</span>
<span id="L161" rel="#L161">161</span>
<span id="L162" rel="#L162">162</span>
<span id="L163" rel="#L163">163</span>
<span id="L164" rel="#L164">164</span>
<span id="L165" rel="#L165">165</span>
<span id="L166" rel="#L166">166</span>
<span id="L167" rel="#L167">167</span>
<span id="L168" rel="#L168">168</span>
<span id="L169" rel="#L169">169</span>
<span id="L170" rel="#L170">170</span>
<span id="L171" rel="#L171">171</span>
<span id="L172" rel="#L172">172</span>
<span id="L173" rel="#L173">173</span>
<span id="L174" rel="#L174">174</span>
<span id="L175" rel="#L175">175</span>
<span id="L176" rel="#L176">176</span>
<span id="L177" rel="#L177">177</span>
<span id="L178" rel="#L178">178</span>
<span id="L179" rel="#L179">179</span>
<span id="L180" rel="#L180">180</span>
<span id="L181" rel="#L181">181</span>
<span id="L182" rel="#L182">182</span>
<span id="L183" rel="#L183">183</span>
<span id="L184" rel="#L184">184</span>
<span id="L185" rel="#L185">185</span>
<span id="L186" rel="#L186">186</span>
<span id="L187" rel="#L187">187</span>
<span id="L188" rel="#L188">188</span>
<span id="L189" rel="#L189">189</span>
<span id="L190" rel="#L190">190</span>
<span id="L191" rel="#L191">191</span>
<span id="L192" rel="#L192">192</span>
<span id="L193" rel="#L193">193</span>
<span id="L194" rel="#L194">194</span>
<span id="L195" rel="#L195">195</span>
<span id="L196" rel="#L196">196</span>
<span id="L197" rel="#L197">197</span>
<span id="L198" rel="#L198">198</span>
<span id="L199" rel="#L199">199</span>
<span id="L200" rel="#L200">200</span>
<span id="L201" rel="#L201">201</span>
<span id="L202" rel="#L202">202</span>
<span id="L203" rel="#L203">203</span>
<span id="L204" rel="#L204">204</span>
<span id="L205" rel="#L205">205</span>
<span id="L206" rel="#L206">206</span>
<span id="L207" rel="#L207">207</span>
<span id="L208" rel="#L208">208</span>
<span id="L209" rel="#L209">209</span>
<span id="L210" rel="#L210">210</span>
<span id="L211" rel="#L211">211</span>
<span id="L212" rel="#L212">212</span>
<span id="L213" rel="#L213">213</span>
<span id="L214" rel="#L214">214</span>
<span id="L215" rel="#L215">215</span>
<span id="L216" rel="#L216">216</span>
<span id="L217" rel="#L217">217</span>
<span id="L218" rel="#L218">218</span>
<span id="L219" rel="#L219">219</span>
<span id="L220" rel="#L220">220</span>
<span id="L221" rel="#L221">221</span>
<span id="L222" rel="#L222">222</span>
<span id="L223" rel="#L223">223</span>
<span id="L224" rel="#L224">224</span>
<span id="L225" rel="#L225">225</span>
<span id="L226" rel="#L226">226</span>
<span id="L227" rel="#L227">227</span>
<span id="L228" rel="#L228">228</span>
<span id="L229" rel="#L229">229</span>
<span id="L230" rel="#L230">230</span>
<span id="L231" rel="#L231">231</span>
<span id="L232" rel="#L232">232</span>
<span id="L233" rel="#L233">233</span>
<span id="L234" rel="#L234">234</span>
<span id="L235" rel="#L235">235</span>
<span id="L236" rel="#L236">236</span>
<span id="L237" rel="#L237">237</span>
<span id="L238" rel="#L238">238</span>
<span id="L239" rel="#L239">239</span>

            </td>
            <td class="blob-line-code">
                    <div class="highlight"><pre><div class='line' id='LC1'><span class="c1">;;; chef-mode.el --- minor mode for editing an opscode chef repository</span></div><div class='line' id='LC2'><br/></div><div class='line' id='LC3'><span class="c1">;; Copyright (C) 2011 Maciej Pasternacki</span></div><div class='line' id='LC4'><br/></div><div class='line' id='LC5'><span class="c1">;; Author: Maciej Pasternacki &lt;maciej@pasternacki.net&gt;</span></div><div class='line' id='LC6'><span class="c1">;; Created: 28 Aug 2011</span></div><div class='line' id='LC7'><span class="c1">;; Version: 0.1</span></div><div class='line' id='LC8'><span class="c1">;; Keywords: chef knife</span></div><div class='line' id='LC9'><br/></div><div class='line' id='LC10'><span class="c1">;; This file is NOT part of GNU Emacs.</span></div><div class='line' id='LC11'><br/></div><div class='line' id='LC12'><span class="c1">;;; License:</span></div><div class='line' id='LC13'><br/></div><div class='line' id='LC14'><span class="c1">;; Copyright (c) 2011, Maciej Pasternacki &lt;maciej@pasternacki.net&gt;</span></div><div class='line' id='LC15'><span class="c1">;; All rights reserved.</span></div><div class='line' id='LC16'><br/></div><div class='line' id='LC17'><span class="c1">;; Redistribution and use in source and binary forms, with or without</span></div><div class='line' id='LC18'><span class="c1">;; modification, are permitted provided that the following conditions are met:</span></div><div class='line' id='LC19'><span class="c1">;;     * Redistributions of source code must retain the above copyright</span></div><div class='line' id='LC20'><span class="c1">;;       notice, this list of conditions and the following disclaimer.</span></div><div class='line' id='LC21'><span class="c1">;;     * Redistributions in binary form must reproduce the above copyright</span></div><div class='line' id='LC22'><span class="c1">;;       notice, this list of conditions and the following disclaimer in the</span></div><div class='line' id='LC23'><span class="c1">;;       documentation and/or other materials provided with the distribution.</span></div><div class='line' id='LC24'><span class="c1">;;     * Neither the name of the copyright holder nor the</span></div><div class='line' id='LC25'><span class="c1">;;       names of its contributors may be used to endorse or promote products</span></div><div class='line' id='LC26'><span class="c1">;;       derived from this software without specific prior written permission.</span></div><div class='line' id='LC27'><br/></div><div class='line' id='LC28'><span class="c1">;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS &quot;AS IS&quot; AND</span></div><div class='line' id='LC29'><span class="c1">;; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED</span></div><div class='line' id='LC30'><span class="c1">;; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE</span></div><div class='line' id='LC31'><span class="c1">;; DISCLAIMED. IN NO EVENT SHALL MACIEJ PASTERNACKI BE LIABLE FOR ANY</span></div><div class='line' id='LC32'><span class="c1">;; DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES</span></div><div class='line' id='LC33'><span class="c1">;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;</span></div><div class='line' id='LC34'><span class="c1">;; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND</span></div><div class='line' id='LC35'><span class="c1">;; ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT</span></div><div class='line' id='LC36'><span class="c1">;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS</span></div><div class='line' id='LC37'><span class="c1">;; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</span></div><div class='line' id='LC38'><br/></div><div class='line' id='LC39'><span class="c1">;;; Commentary:</span></div><div class='line' id='LC40'><br/></div><div class='line' id='LC41'><span class="c1">;; This library defines a minor mode to work with Opscode Chef</span></div><div class='line' id='LC42'><span class="c1">;; (http://www.opscode.com/chef/) repository. It creates two</span></div><div class='line' id='LC43'><span class="c1">;; keybindings:</span></div><div class='line' id='LC44'><br/></div><div class='line' id='LC45'><span class="c1">;; - C-c C-c (M-x chef-knife-dwim) - when editing part of chef</span></div><div class='line' id='LC46'><span class="c1">;;   repository (cookbook, data bag item, node/role/environment</span></div><div class='line' id='LC47'><span class="c1">;;   definition), uploads that part to the Chef Server by calling</span></div><div class='line' id='LC48'><span class="c1">;;   appropriate knife command</span></div><div class='line' id='LC49'><span class="c1">;; - C-c C-k (M-x knife) - runs a user-specified knife command</span></div><div class='line' id='LC50'><br/></div><div class='line' id='LC51'><span class="c1">;; The library detects bundler and, if Gemfile is present on top-level</span></div><div class='line' id='LC52'><span class="c1">;; of the Chef repository, runs &#39;bundle exec knife&#39; instead of plain</span></div><div class='line' id='LC53'><span class="c1">;; &#39;knife&#39;.</span></div><div class='line' id='LC54'><br/></div><div class='line' id='LC55'><span class="c1">;; If chef-use-rvm is non-nil, it talks with rvm.el</span></div><div class='line' id='LC56'><span class="c1">;; (https://github.com/senny/rvm.el) to use proper Ruby and gemset.</span></div><div class='line' id='LC57'><br/></div><div class='line' id='LC58'><span class="c1">;;; Code:</span></div><div class='line' id='LC59'><br/></div><div class='line' id='LC60'><br/></div><div class='line' id='LC61'><span class="p">(</span><span class="nf">defvar</span> <span class="nv">chef-knife-command</span> <span class="s">&quot;knife&quot;</span></div><div class='line' id='LC62'>&nbsp;&nbsp;<span class="s">&quot;Knife command to run&quot;</span><span class="p">)</span></div><div class='line' id='LC63'><br/></div><div class='line' id='LC64'><span class="p">(</span><span class="nf">defvar</span> <span class="nv">chef-use-bundler</span> <span class="nv">t</span></div><div class='line' id='LC65'>&nbsp;&nbsp;<span class="s">&quot;Use `bundle exec knife&#39; if Gemfile exists&quot;</span><span class="p">)</span></div><div class='line' id='LC66'><br/></div><div class='line' id='LC67'><span class="p">(</span><span class="nf">defvar</span> <span class="nv">chef-use-rvm</span> <span class="nv">t</span></div><div class='line' id='LC68'>&nbsp;&nbsp;<span class="s">&quot;If non-nil, require rvm.el and call rvm-activate-corresponding-ruby on chef repo root before calling knife&quot;</span><span class="p">)</span></div><div class='line' id='LC69'><br/></div><div class='line' id='LC70'><span class="p">(</span><span class="nf">defvar</span> <span class="nv">chef-mode-map</span> <span class="p">(</span><span class="nf">make-sparse-keymap</span><span class="p">)</span></div><div class='line' id='LC71'>&nbsp;&nbsp;<span class="s">&quot;Key map for chef-mode&quot;</span><span class="p">)</span></div><div class='line' id='LC72'><br/></div><div class='line' id='LC73'><span class="p">(</span><span class="nf">define-key</span> <span class="nv">chef-mode-map</span> <span class="p">(</span><span class="nf">kbd</span> <span class="s">&quot;\C-c \C-k&quot;</span><span class="p">)</span> <span class="ss">&#39;knife</span><span class="p">)</span></div><div class='line' id='LC74'><span class="p">(</span><span class="nf">define-key</span> <span class="nv">chef-mode-map</span> <span class="p">(</span><span class="nf">kbd</span> <span class="s">&quot;\C-c \C-c&quot;</span><span class="p">)</span> <span class="ss">&#39;chef-knife-dwim</span><span class="p">)</span></div><div class='line' id='LC75'><br/></div><div class='line' id='LC76'><span class="p">(</span><span class="nf">define-minor-mode</span> <span class="nv">chef-mode</span></div><div class='line' id='LC77'>&nbsp;&nbsp;<span class="s">&quot;Mode for interacting with Opscode Chef&quot;</span></div><div class='line' id='LC78'>&nbsp;&nbsp;<span class="nv">nil</span> <span class="nv">chef-mode-map</span><span class="p">)</span></div><div class='line' id='LC79'><br/></div><div class='line' id='LC80'><span class="p">(</span><span class="nf">defun</span> <span class="nv">turn-on-chef-mode</span> <span class="p">()</span></div><div class='line' id='LC81'>&nbsp;&nbsp;<span class="s">&quot;Enable chef-mode.&quot;</span></div><div class='line' id='LC82'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">chef-mode</span> <span class="mi">1</span><span class="p">))</span></div><div class='line' id='LC83'><br/></div><div class='line' id='LC84'><span class="p">(</span><span class="nf">define-globalized-minor-mode</span> <span class="nv">global-chef-mode</span></div><div class='line' id='LC85'>&nbsp;&nbsp;<span class="nv">chef-mode</span> <span class="nv">turn-on-chef-mode</span><span class="p">)</span></div><div class='line' id='LC86'><br/></div><div class='line' id='LC87'><span class="p">(</span><span class="nf">defun</span> <span class="nv">find-chef-root</span> <span class="p">(</span><span class="nf">&amp;optional</span> <span class="nv">path</span><span class="p">)</span></div><div class='line' id='LC88'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">when</span> <span class="p">(</span><span class="nf">null</span> <span class="nv">path</span><span class="p">)</span></div><div class='line' id='LC89'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">setq</span> <span class="nv">path</span> <span class="p">(</span><span class="k">or </span><span class="nv">buffer-file-name</span></div><div class='line' id='LC90'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">default-directory</span><span class="p">)))</span></div><div class='line' id='LC91'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">cond</span></div><div class='line' id='LC92'>&nbsp;&nbsp;&nbsp;<span class="p">((</span><span class="nb">not </span><span class="p">(</span><span class="nf">file-directory-p</span> <span class="nv">path</span><span class="p">))</span></div><div class='line' id='LC93'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">find-chef-root</span> <span class="p">(</span><span class="nf">concat</span> <span class="p">(</span><span class="nf">file-name-as-directory</span> <span class="nv">path</span><span class="p">)</span> <span class="s">&quot;..&quot;</span><span class="p">)))</span></div><div class='line' id='LC94'>&nbsp;&nbsp;&nbsp;<span class="p">((</span><span class="nf">equal</span> <span class="p">(</span><span class="nf">expand-file-name</span> <span class="nv">path</span><span class="p">)</span> <span class="p">(</span><span class="nf">expand-file-name</span> <span class="s">&quot;~&quot;</span><span class="p">))</span> <span class="nv">nil</span><span class="p">)</span></div><div class='line' id='LC95'>&nbsp;&nbsp;&nbsp;<span class="p">((</span><span class="nf">equal</span> <span class="p">(</span><span class="nf">expand-file-name</span> <span class="nv">path</span><span class="p">)</span> <span class="s">&quot;/&quot;</span><span class="p">)</span> <span class="nv">nil</span><span class="p">)</span></div><div class='line' id='LC96'>&nbsp;&nbsp;&nbsp;<span class="p">((</span><span class="k">let </span><span class="p">((</span><span class="nf">ff</span> <span class="p">(</span><span class="nf">directory-files</span> <span class="nv">path</span><span class="p">)))</span></div><div class='line' id='LC97'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="k">or </span><span class="p">(</span><span class="nb">member </span><span class="s">&quot;.chef&quot;</span> <span class="nv">ff</span><span class="p">)</span></div><div class='line' id='LC98'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="k">and </span><span class="p">(</span><span class="nb">member </span><span class="s">&quot;cookbooks&quot;</span> <span class="nv">ff</span><span class="p">)</span></div><div class='line' id='LC99'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nb">member </span><span class="s">&quot;roles&quot;</span> <span class="nv">ff</span><span class="p">)</span></div><div class='line' id='LC100'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nb">member </span><span class="s">&quot;config&quot;</span> <span class="nv">ff</span><span class="p">))))</span></div><div class='line' id='LC101'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">file-name-as-directory</span> <span class="p">(</span><span class="nf">expand-file-name</span> <span class="nv">path</span><span class="p">)))</span></div><div class='line' id='LC102'>&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">t</span> <span class="p">(</span><span class="nf">find-chef-root</span> <span class="p">(</span><span class="nf">concat</span> <span class="p">(</span><span class="nf">file-name-as-directory</span> <span class="nv">path</span><span class="p">)</span> <span class="s">&quot;..&quot;</span><span class="p">)))))</span></div><div class='line' id='LC103'><br/></div><div class='line' id='LC104'><span class="p">(</span><span class="nf">defun</span> <span class="nv">chef/fallback</span> <span class="p">(</span><span class="nf">trigger</span><span class="p">)</span></div><div class='line' id='LC105'>&nbsp;&nbsp;<span class="p">(</span><span class="k">let* </span><span class="p">((</span><span class="nf">chef-mode</span> <span class="nv">nil</span><span class="p">)</span></div><div class='line' id='LC106'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">command</span> <span class="p">(</span><span class="nf">key-binding</span> <span class="nv">trigger</span><span class="p">)))</span></div><div class='line' id='LC107'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">when</span> <span class="p">(</span><span class="nf">commandp</span> <span class="nv">command</span><span class="p">)</span></div><div class='line' id='LC108'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">call-interactively</span> <span class="nv">command</span><span class="p">))))</span></div><div class='line' id='LC109'><br/></div><div class='line' id='LC110'><span class="p">(</span><span class="nf">defmacro</span> <span class="nv">chef/with-root-or-fallback</span> <span class="p">(</span><span class="nf">trigger</span> <span class="nv">&amp;rest</span> <span class="nv">body</span><span class="p">)</span></div><div class='line' id='LC111'>&nbsp;&nbsp;<span class="o">`</span><span class="p">(</span><span class="k">let </span><span class="p">((</span><span class="nf">chef-root</span> <span class="p">(</span><span class="nf">find-chef-root</span><span class="p">)))</span></div><div class='line' id='LC112'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="k">if </span><span class="p">(</span><span class="nf">null</span> <span class="nv">chef-root</span><span class="p">)</span></div><div class='line' id='LC113'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">chef/fallback</span> <span class="o">,</span><span class="nv">trigger</span><span class="p">)</span></div><div class='line' id='LC114'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="o">,@</span><span class="nv">body</span><span class="p">)))</span></div><div class='line' id='LC115'><br/></div><div class='line' id='LC116'><span class="p">(</span><span class="nf">defun</span> <span class="nv">chef-run-knife</span> <span class="p">(</span><span class="nf">command</span> <span class="nv">&amp;rest</span> <span class="nv">args</span><span class="p">)</span></div><div class='line' id='LC117'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">when</span> <span class="nv">chef-use-rvm</span></div><div class='line' id='LC118'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">rvm-activate-corresponding-ruby</span><span class="p">))</span></div><div class='line' id='LC119'><br/></div><div class='line' id='LC120'>&nbsp;&nbsp;<span class="p">(</span><span class="k">let </span><span class="p">((</span><span class="nf">knife-buffer</span> <span class="p">(</span><span class="nf">get-buffer-create</span> <span class="s">&quot;*knife*&quot;</span><span class="p">))</span></div><div class='line' id='LC121'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">use-bundler</span> <span class="p">(</span><span class="k">and </span><span class="nv">chef-use-bundler</span> <span class="p">(</span><span class="nf">file-exists-p</span> <span class="s">&quot;Gemfile&quot;</span><span class="p">))))</span></div><div class='line' id='LC122'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">with-current-buffer</span> <span class="nv">knife-buffer</span></div><div class='line' id='LC123'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">setq</span> <span class="nv">default-directory</span> <span class="nv">chef-root</span><span class="p">)</span></div><div class='line' id='LC124'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">setq</span> <span class="nv">list-buffers-directory</span> <span class="nv">default-directory</span><span class="p">)</span></div><div class='line' id='LC125'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">toggle-read-only</span> <span class="mi">0</span><span class="p">)</span></div><div class='line' id='LC126'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">erase-buffer</span><span class="p">)</span></div><div class='line' id='LC127'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">insert-string</span> <span class="p">(</span><span class="nf">concat</span> <span class="s">&quot;# &quot;</span> <span class="nv">default-directory</span> <span class="s">&quot;\n&quot;</span></div><div class='line' id='LC128'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">when</span> <span class="nv">use-bundler</span></div><div class='line' id='LC129'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="s">&quot;bundle exec &quot;</span><span class="p">)</span></div><div class='line' id='LC130'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">chef-knife-command</span> <span class="s">&quot; &quot;</span> <span class="nv">command</span> <span class="s">&quot; &quot;</span></div><div class='line' id='LC131'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">mapconcat</span> <span class="ss">&#39;identity</span> <span class="nv">args</span> <span class="s">&quot; &quot;</span><span class="p">)</span></div><div class='line' id='LC132'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="s">&quot;\n\n&quot;</span><span class="p">)))</span></div><div class='line' id='LC133'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="k">if </span><span class="nv">use-bundler</span></div><div class='line' id='LC134'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nb">apply </span><span class="ss">&#39;call-process</span></div><div class='line' id='LC135'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="s">&quot;bundle&quot;</span> <span class="nv">nil</span> <span class="nv">knife-buffer</span></div><div class='line' id='LC136'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="s">&quot;bundle&quot;</span> <span class="s">&quot;exec&quot;</span> <span class="nv">chef-knife-command</span> <span class="p">(</span><span class="nb">cons </span><span class="nv">command</span> <span class="nv">args</span><span class="p">))</span></div><div class='line' id='LC137'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nb">apply </span><span class="ss">&#39;call-process</span></div><div class='line' id='LC138'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">chef-knife-command</span> <span class="nv">nil</span> <span class="nv">knife-buffer</span></div><div class='line' id='LC139'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">chef-knife-command</span> <span class="p">(</span><span class="nb">cons </span><span class="nv">command</span> <span class="nv">args</span><span class="p">)))</span></div><div class='line' id='LC140'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">with-current-buffer</span> <span class="nv">knife-buffer</span></div><div class='line' id='LC141'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">toggle-read-only</span> <span class="mi">1</span><span class="p">))</span></div><div class='line' id='LC142'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">switch-to-buffer-other-window</span> <span class="nv">knife-buffer</span> <span class="nv">t</span><span class="p">)</span></div><div class='line' id='LC143'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">fit-window-to-buffer</span><span class="p">)))</span></div><div class='line' id='LC144'><br/></div><div class='line' id='LC145'><span class="p">(</span><span class="nf">defun</span> <span class="nv">knife</span> <span class="p">(</span><span class="nf">command</span><span class="p">)</span></div><div class='line' id='LC146'>&nbsp;&nbsp;<span class="s">&quot;Run knife&quot;</span></div><div class='line' id='LC147'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">interactive</span> <span class="s">&quot;Command: knife &quot;</span><span class="p">)</span></div><div class='line' id='LC148'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">chef/with-root-or-fallback</span></div><div class='line' id='LC149'>&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">kbd</span> <span class="s">&quot;\C-c \C-k&quot;</span><span class="p">)</span></div><div class='line' id='LC150'>&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nb">apply </span><span class="ss">&#39;chef-run-knife</span> <span class="p">(</span><span class="nf">split-string-and-unquote</span> <span class="nv">command</span><span class="p">))))</span></div><div class='line' id='LC151'><br/></div><div class='line' id='LC152'><span class="p">(</span><span class="nf">defun</span> <span class="nv">chef-knife-dwim</span> <span class="p">()</span></div><div class='line' id='LC153'>&nbsp;&nbsp;<span class="s">&quot;Upload currently edited thing to the Chef server.</span></div><div class='line' id='LC154'><br/></div><div class='line' id='LC155'><span class="s">Guesses whether you have &quot;</span></div><div class='line' id='LC156'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">interactive</span><span class="p">)</span></div><div class='line' id='LC157'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">chef/with-root-or-fallback</span></div><div class='line' id='LC158'>&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">kbd</span> <span class="s">&quot;\C-c \C-c&quot;</span><span class="p">)</span></div><div class='line' id='LC159'>&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="k">let </span><span class="p">((</span><span class="nf">b</span> <span class="p">(</span><span class="nf">current-buffer</span><span class="p">)))</span></div><div class='line' id='LC160'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">save-some-buffers</span> <span class="nv">nil</span> <span class="p">(</span><span class="k">lambda </span><span class="p">()</span></div><div class='line' id='LC161'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">eq</span> <span class="nv">b</span> <span class="p">(</span><span class="nf">current-buffer</span><span class="p">)))))</span></div><div class='line' id='LC162'>&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="k">if </span><span class="nv">buffer-file-name</span></div><div class='line' id='LC163'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="k">let </span><span class="p">((</span><span class="nf">default-directory</span> <span class="nv">chef-root</span><span class="p">)</span></div><div class='line' id='LC164'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">rpath</span> <span class="p">(</span><span class="nf">file-relative-name</span> <span class="nv">buffer-file-name</span> <span class="nv">chef-root</span><span class="p">)))</span></div><div class='line' id='LC165'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">cond</span></div><div class='line' id='LC166'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">((</span><span class="nf">string-match</span> <span class="s">&quot;^\\(?:site-\\)?cookbooks/\\([^/]+\\)/&quot;</span> <span class="nv">rpath</span><span class="p">)</span></div><div class='line' id='LC167'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">print</span> <span class="p">(</span><span class="nf">match-string</span> <span class="mi">1</span> <span class="nv">rpath</span><span class="p">))</span></div><div class='line' id='LC168'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">chef-run-knife</span> <span class="s">&quot;cookbook&quot;</span> <span class="s">&quot;upload&quot;</span> <span class="p">(</span><span class="nf">match-string</span> <span class="mi">1</span> <span class="nv">rpath</span><span class="p">)))</span></div><div class='line' id='LC169'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">((</span><span class="nf">string-match</span> <span class="s">&quot;^\\(role\\|node\\|environment\\)s/\\(.*\\)&quot;</span> <span class="nv">rpath</span><span class="p">)</span></div><div class='line' id='LC170'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">chef-run-knife</span> <span class="p">(</span><span class="nf">match-string</span> <span class="mi">1</span> <span class="nv">rpath</span><span class="p">)</span> <span class="s">&quot;from&quot;</span> <span class="s">&quot;file&quot;</span> <span class="p">(</span><span class="nf">match-string</span> <span class="mi">2</span> <span class="nv">rpath</span><span class="p">)))</span></div><div class='line' id='LC171'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">((</span><span class="nf">string-match</span> <span class="s">&quot;^data.bags/\\([^/]+\\)/\\(.*\\.yaml\\)&quot;</span> <span class="nv">rpath</span><span class="p">)</span></div><div class='line' id='LC172'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">chef-run-knife</span> <span class="s">&quot;data&quot;</span> <span class="s">&quot;bag&quot;</span> <span class="s">&quot;from&quot;</span> <span class="s">&quot;yaml&quot;</span> <span class="p">(</span><span class="nf">match-string</span> <span class="mi">1</span> <span class="nv">rpath</span><span class="p">)</span> <span class="p">(</span><span class="nf">match-string</span> <span class="mi">2</span> <span class="nv">rpath</span><span class="p">)))</span></div><div class='line' id='LC173'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">((</span><span class="nf">string-match</span> <span class="s">&quot;^data.bags/\\([^/]+\\)/\\(.*\\)&quot;</span> <span class="nv">rpath</span><span class="p">)</span></div><div class='line' id='LC174'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">chef-run-knife</span> <span class="s">&quot;data&quot;</span> <span class="s">&quot;bag&quot;</span> <span class="s">&quot;from&quot;</span> <span class="s">&quot;file&quot;</span> <span class="p">(</span><span class="nf">match-string</span> <span class="mi">1</span> <span class="nv">rpath</span><span class="p">)</span> <span class="p">(</span><span class="nf">match-string</span> <span class="mi">2</span> <span class="nv">rpath</span><span class="p">)))</span></div><div class='line' id='LC175'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">t</span> <span class="p">(</span><span class="nf">chef/fallback</span> <span class="p">(</span><span class="nf">kbd</span> <span class="s">&quot;\C-c \C-c&quot;</span><span class="p">)))))</span></div><div class='line' id='LC176'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">chef/fallback</span> <span class="p">(</span><span class="nf">kbd</span> <span class="s">&quot;\C-c \C-c&quot;</span><span class="p">)))))</span></div><div class='line' id='LC177'><br/></div><div class='line' id='LC178'><br/></div><div class='line' id='LC179'><br/></div><div class='line' id='LC180'><span class="p">(</span><span class="nf">defun</span> <span class="nv">chef-resource-lookup</span> <span class="p">()</span></div><div class='line' id='LC181'>&nbsp;&nbsp;<span class="s">&quot;Open the documentation in a browser for the chef resource at point&quot;</span></div><div class='line' id='LC182'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">interactive</span><span class="p">)</span></div><div class='line' id='LC183'>&nbsp;&nbsp;<span class="p">(</span><span class="k">let* </span><span class="p">((</span><span class="nf">base</span> <span class="s">&quot;http://wiki.opscode.com/display/chef/Resources&quot;</span><span class="p">)</span></div><div class='line' id='LC184'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">anchor</span> <span class="s">&quot;#Resources-&quot;</span><span class="p">)</span></div><div class='line' id='LC185'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">tbl</span> <span class="o">&#39;</span><span class="p">(</span></div><div class='line' id='LC186'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;cookbook_file&quot;</span> <span class="o">.</span> <span class="s">&quot;CookbookFile&quot;</span><span class="p">)</span></div><div class='line' id='LC187'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;cron&quot;</span> <span class="o">.</span> <span class="s">&quot;Cron&quot;</span><span class="p">)</span></div><div class='line' id='LC188'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;deploy&quot;</span> <span class="o">.</span> <span class="s">&quot;Deploy&quot;</span><span class="p">)</span></div><div class='line' id='LC189'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;directory&quot;</span> <span class="o">.</span> <span class="s">&quot;Directory&quot;</span><span class="p">)</span></div><div class='line' id='LC190'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;env&quot;</span> <span class="o">.</span> <span class="s">&quot;Env&quot;</span><span class="p">)</span></div><div class='line' id='LC191'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;erl_call&quot;</span> <span class="o">.</span> <span class="s">&quot;ErlangCall&quot;</span><span class="p">)</span></div><div class='line' id='LC192'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;execute&quot;</span> <span class="o">.</span> <span class="s">&quot;Execute&quot;</span><span class="p">)</span></div><div class='line' id='LC193'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;file&quot;</span> <span class="o">.</span> <span class="s">&quot;File&quot;</span><span class="p">)</span></div><div class='line' id='LC194'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;git&quot;</span> <span class="o">.</span> <span class="s">&quot;Git&quot;</span><span class="p">)</span></div><div class='line' id='LC195'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;group&quot;</span> <span class="o">.</span> <span class="s">&quot;Group&quot;</span><span class="p">)</span></div><div class='line' id='LC196'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;http_request&quot;</span> <span class="o">.</span> <span class="s">&quot;HTTPRequest&quot;</span><span class="p">)</span></div><div class='line' id='LC197'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;ifconfig&quot;</span> <span class="o">.</span> <span class="s">&quot;Ifconfig&quot;</span><span class="p">)</span></div><div class='line' id='LC198'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;link&quot;</span> <span class="o">.</span> <span class="s">&quot;Link&quot;</span><span class="p">)</span></div><div class='line' id='LC199'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;log&quot;</span> <span class="o">.</span> <span class="s">&quot;Log&quot;</span><span class="p">)</span></div><div class='line' id='LC200'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;mdadm&quot;</span> <span class="o">.</span> <span class="s">&quot;Mdadm&quot;</span><span class="p">)</span></div><div class='line' id='LC201'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;mount&quot;</span> <span class="o">.</span> <span class="s">&quot;Mount&quot;</span><span class="p">)</span></div><div class='line' id='LC202'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;ohai&quot;</span> <span class="o">.</span> <span class="s">&quot;Ohai&quot;</span><span class="p">)</span></div><div class='line' id='LC203'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;package&quot;</span> <span class="o">.</span> <span class="s">&quot;Package&quot;</span><span class="p">)</span></div><div class='line' id='LC204'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;apt_package&quot;</span> <span class="o">.</span> <span class="s">&quot;Package&quot;</span><span class="p">)</span></div><div class='line' id='LC205'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;dpkg_package&quot;</span> <span class="o">.</span> <span class="s">&quot;Package&quot;</span><span class="p">)</span></div><div class='line' id='LC206'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;easy_install_package&quot;</span> <span class="o">.</span> <span class="s">&quot;Package&quot;</span><span class="p">)</span></div><div class='line' id='LC207'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;freebsd_package&quot;</span> <span class="o">.</span> <span class="s">&quot;Package&quot;</span><span class="p">)</span></div><div class='line' id='LC208'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;macports_package&quot;</span> <span class="o">.</span> <span class="s">&quot;Package&quot;</span><span class="p">)</span></div><div class='line' id='LC209'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;portage_package&quot;</span> <span class="o">.</span> <span class="s">&quot;Package&quot;</span><span class="p">)</span></div><div class='line' id='LC210'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;rpm_package&quot;</span> <span class="o">.</span> <span class="s">&quot;Package&quot;</span><span class="p">)</span></div><div class='line' id='LC211'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;gem_package&quot;</span> <span class="o">.</span> <span class="s">&quot;Package&quot;</span><span class="p">)</span></div><div class='line' id='LC212'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;yum_package&quot;</span> <span class="o">.</span> <span class="s">&quot;Package&quot;</span><span class="p">)</span></div><div class='line' id='LC213'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;zypper_package&quot;</span> <span class="o">.</span> <span class="s">&quot;Package&quot;</span><span class="p">)</span></div><div class='line' id='LC214'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;powershell&quot;</span> <span class="o">.</span> <span class="s">&quot;PowerShellScript&quot;</span><span class="p">)</span></div><div class='line' id='LC215'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;remote_directory&quot;</span> <span class="o">.</span> <span class="s">&quot;RemoteDirectory&quot;</span><span class="p">)</span></div><div class='line' id='LC216'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;remote_file&quot;</span> <span class="o">.</span> <span class="s">&quot;RemoteFile&quot;</span><span class="p">)</span></div><div class='line' id='LC217'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;route&quot;</span> <span class="o">.</span> <span class="s">&quot;Route&quot;</span><span class="p">)</span></div><div class='line' id='LC218'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;ruby_block&quot;</span> <span class="o">.</span> <span class="s">&quot;RubyBlock&quot;</span><span class="p">)</span></div><div class='line' id='LC219'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;scm&quot;</span> <span class="o">.</span> <span class="s">&quot;SCM&quot;</span><span class="p">)</span></div><div class='line' id='LC220'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;script&quot;</span> <span class="o">.</span> <span class="s">&quot;Script&quot;</span><span class="p">)</span></div><div class='line' id='LC221'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;bash&quot;</span> <span class="o">.</span> <span class="s">&quot;Script&quot;</span><span class="p">)</span></div><div class='line' id='LC222'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;csh&quot;</span> <span class="o">.</span> <span class="s">&quot;Script&quot;</span><span class="p">)</span></div><div class='line' id='LC223'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;perl&quot;</span> <span class="o">.</span> <span class="s">&quot;Script&quot;</span><span class="p">)</span></div><div class='line' id='LC224'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;python&quot;</span> <span class="o">.</span> <span class="s">&quot;Script&quot;</span><span class="p">)</span></div><div class='line' id='LC225'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;ruby&quot;</span> <span class="o">.</span> <span class="s">&quot;Script&quot;</span><span class="p">)</span></div><div class='line' id='LC226'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;service&quot;</span> <span class="o">.</span> <span class="s">&quot;Service&quot;</span><span class="p">)</span></div><div class='line' id='LC227'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;subversion&quot;</span> <span class="o">.</span> <span class="s">&quot;Subversion&quot;</span><span class="p">)</span></div><div class='line' id='LC228'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;template&quot;</span> <span class="o">.</span> <span class="s">&quot;Template&quot;</span><span class="p">)</span></div><div class='line' id='LC229'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="s">&quot;user&quot;</span> <span class="o">.</span> <span class="s">&quot;User&quot;</span><span class="p">)</span></div><div class='line' id='LC230'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">))</span></div><div class='line' id='LC231'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">target</span> <span class="p">(</span><span class="nf">assoc-string</span> <span class="p">(</span><span class="nf">symbol-at-point</span><span class="p">)</span> <span class="nv">tbl</span><span class="p">)))</span></div><div class='line' id='LC232'><br/></div><div class='line' id='LC233'>&nbsp;&nbsp;<span class="p">(</span><span class="k">if </span><span class="nv">target</span></div><div class='line' id='LC234'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">browse-url</span> <span class="p">(</span><span class="nf">concat</span> <span class="nv">base</span> <span class="nv">anchor</span> <span class="p">(</span><span class="nb">cdr </span><span class="nv">target</span><span class="p">)))</span></div><div class='line' id='LC235'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">browse-url</span> <span class="nv">base</span><span class="p">))))</span></div><div class='line' id='LC236'><br/></div><div class='line' id='LC237'><br/></div><div class='line' id='LC238'><span class="p">(</span><span class="nf">provide</span> <span class="ss">&#39;chef-mode</span><span class="p">)</span></div><div class='line' id='LC239'><span class="c1">;;; chef-mode.el ends here</span></div></pre></div>
            </td>
          </tr>
        </table>
  </div>

  </div>
</div>

<a href="#jump-to-line" rel="facebox[.linejump]" data-hotkey="l" class="js-jump-to-line" style="display:none">Jump to Line</a>
<div id="jump-to-line" style="display:none">
  <form accept-charset="UTF-8" class="js-jump-to-line-form">
    <input class="linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" autofocus>
    <button type="submit" class="button">Go</button>
  </form>
</div>

        </div>

      </div><!-- /.repo-container -->
      <div class="modal-backdrop"></div>
    </div><!-- /.container -->
  </div><!-- /.site -->


    </div><!-- /.wrapper -->

      <div class="container">
  <div class="site-footer">
    <ul class="site-footer-links right">
      <li><a href="https://status.github.com/">Status</a></li>
      <li><a href="http://developer.github.com">API</a></li>
      <li><a href="http://training.github.com">Training</a></li>
      <li><a href="http://shop.github.com">Shop</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/about">About</a></li>

    </ul>

    <a href="/">
      <span class="mega-octicon octicon-mark-github"></span>
    </a>

    <ul class="site-footer-links">
      <li>&copy; 2013 <span title="0.04411s from github-fe115-cp1-prd.iad.github.net">GitHub</span>, Inc.</li>
        <li><a href="/site/terms">Terms</a></li>
        <li><a href="/site/privacy">Privacy</a></li>
        <li><a href="/security">Security</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
  </div><!-- /.site-footer -->
</div><!-- /.container -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-fullscreen-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="js-fullscreen-contents" placeholder="" data-suggester="fullscreen_suggester"></textarea>
          <div class="suggester-container">
              <div class="suggester fullscreen-suggester js-navigation-container" id="fullscreen_suggester"
                 data-url="/mpasternacki/chef-mode/suggestions/commit">
              </div>
          </div>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped leftwards" title="Exit Zen Mode">
      <span class="mega-octicon octicon-screen-normal"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped leftwards"
      title="Switch themes">
      <span class="octicon octicon-color-mode"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="octicon octicon-alert"></span>
      <a href="#" class="octicon octicon-remove-close close ajax-error-dismiss"></a>
      Something went wrong with that request. Please try again.
    </div>

    
  </body>
</html>

