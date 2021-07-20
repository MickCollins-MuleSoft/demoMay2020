%dw 2.0
import * from dw::test::Asserts
---
payload must equalTo("<!--\n\n    MuleSoft Examples\n    Copyright 2014 MuleSoft, Inc.\n\n    This product includes software developed at\n    MuleSoft, Inc. (http://www.mulesoft.com/).\n\n-->\n\n<html>\n\t<body>\n\t\t User has been logged successfully!\n\t</body>\n</html>")