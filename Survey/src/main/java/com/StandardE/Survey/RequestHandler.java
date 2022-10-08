package com.StandardE.Survey;

import com.amazonaws.services.lambda.runtime.Context;

public interface RequestHandler {
    Object handleRequest(String s, Context context);
}
