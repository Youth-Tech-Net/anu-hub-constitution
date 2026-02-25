# Youth Tech Net ANU Hub — Governance Documents

This repository contains the authoritative sources for the Youth Tech Net ANU Hub
[constitution](constitution.xml) and [policies](policies.xml), plus the
infrastructure to compile and publish them. Together these two documents govern
how the club and its executive operate.

This repo is based off the ANU Computer Science Students' Association's Governance Gitlab server, visible here (ANU login required):
[https://gitlab.comp.anu.edu.au/cssa/governance](https://gitlab.comp.anu.edu.au/cssa/governance)

## For contributors

The constitution can only be amended by a two-thirds majority of full members
present and voting at a General Meeting, with at least 5 days' notice given to members.
The policies can be amended by a simple majority of the Executive at an Executive meeting.

If you'd like to propose a change, you can describe it in plain English, e.g.
"Section 4 (Aims and Objectives), item 2: add 'hackathons' to the list of
event types". You're also welcome to propose a Git diff if you'd like to.

## Technical details

The documents are written in [DocBook][4] 5, a structured and semantically rich
XML-based document format. This offers many nice features, like automatic
cross-references to defined terms and other sections that can't become
mis-numbered over time, including Git revision history on the title page, and
output to HTML and PDF with very fine control over formatting (using
[DocBook xslTNG][5]).

[4]: https://tdg.docbook.org/tdg/5.1/
[5]: https://xsltng.docbook.org

To build them yourself, you will need Git, GNU make, Java 8+, cURL, and an
internet connection. Clone the repository and run `make`; the documents will be
compiled in a directory called `html`.

(If you'd like to build without internet, you can manually download a release
of DocBook xslTNG from [GitHub][6] and extract it to a directory called
`xsltng`.)

[6]: https://github.com/docbook/xslTNG/releases

## For maintainers

This section is important for the Club secretary, or anyone helping them
look after these documents.

The Git history of the documents themselves (`constitution.xml` and
`policies.xml`) is quite important, as it forms the revision history shown on
their front pages. The commit **author** should be the person who authored /
proposed the change, and the commit **author date** should be the date and time
of the meeting where the change was resolved. The committer should be the
secretary, and the commit date can be left as is.

TL;DR: do this:

    $ git config user.name "Your (Secretary's) Name Here"
    $ git config user.email your.email@anu.edu.au
    $ git commit --author='Amendment Author <author.email@anu.edu.au>' --date='2025-01-01T18:30' -m 'Impartial description of the change'

The build infrastructure, stylesheets, etc. need no such special treatment; you
can commit changes to those as usual.
