package com.StandardE.Survey;

import com.amazonaws.services.lambda.runtime.Context;

public class ServiceHandler implements RequestHandler{
    @Override
    public Object handleRequest(String s, Context context) {
        context.getLogger().log("Input: " + s);
        return "Lambda Function is invoked...." + s;
    }
}
