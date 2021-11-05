package com.example.ykassa_app

import android.app.Activity
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.android.synthetic.main.activity_main.*
import ru.yoomoney.sdk.kassa.payments.Checkout
import ru.yoomoney.sdk.kassa.payments.Checkout.createSavedCardTokenizeIntent
import ru.yoomoney.sdk.kassa.payments.Checkout.createTokenizeIntent
import ru.yoomoney.sdk.kassa.payments.checkoutParameters.*
import ru.yoomoney.sdk.kassa.payments.ui.color.ColorScheme
import java.math.BigDecimal
import java.util.*

class MainActivity: FlutterActivity() {

    private val CHANNEL = "samples.flutter.dev/pay"

    private lateinit var _result: MethodChannel.Result

    val CLIENT_ID = "hitm6hg51j1d3g1u3ln040bajiol903b"
    val GATEWAY_ID: String? = null
    val MERCHANT_TOKEN = "mobile_sdk_key"
    val SHOP_ID = "821006"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            _result = result
            if (call.method == "payMethod") {
                val value: Double? = call.argument("value")
                onTokenizeButtonCLick(value)
//                saveParamsPay(value)
            } else {
                _result.notImplemented()
            }
        }
    }


//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        initUi()
//    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == REQUEST_CODE_TOKENIZE) {
            when (resultCode) {
                Activity.RESULT_OK -> {
                    if (data != null) {

                        _result.success(Checkout.createTokenizationResult(data).paymentToken)
//                        Log.d("!!!!##############!!!", Checkout.createTokenizationResult(data).paymentMethodType);

                    }
                }
                Activity.RESULT_CANCELED -> {
                    if (data != null) {
                        _result.success("Ошибка токена!")
                    }
                }
            }
        }
    }

//    private fun initUi() {
//        setContentView(R.layout.activity_main)
//        tokenizeButton.setOnClickListener {
////            onTokenizeButtonCLick(15.0)
//            saveParamsPay(15.0)
//        }
//    }

    private fun onTokenizeButtonCLick(value: Double?) {
        val paymentMethodTypes = setOf(
                PaymentMethodType.GOOGLE_PAY,
                PaymentMethodType.BANK_CARD,
                PaymentMethodType.SBERBANK,
                PaymentMethodType.YOO_MONEY
        )
        val paymentParameters = PaymentParameters(
                amount = Amount(BigDecimal.valueOf(value!!), Currency.getInstance("RUB")),
                title = getString(R.string.main_product_name),
                subtitle = getString(R.string.main_product_description),
                clientApplicationKey = MERCHANT_TOKEN,
                shopId = SHOP_ID,
                savePaymentMethod = SavePaymentMethod.USER_SELECTS,
                paymentMethodTypes = paymentMethodTypes,
                gatewayId = GATEWAY_ID,
                customReturnUrl = getString(R.string.test_redirect_url),
                userPhoneNumber = getString(R.string.test_phone_number),
                googlePayParameters = GooglePayParameters(),
                authCenterClientId= CLIENT_ID
        )

        val uiParameters = UiParameters(false, ColorScheme(Color.rgb(102, 187, 106)))

        val intent = createTokenizeIntent(this, paymentParameters, uiParameters = uiParameters)
        startActivityForResult(intent, REQUEST_CODE_TOKENIZE)
    }

    private fun saveParamsPay(value: Double?) {
        val parameters = SavedBankCardPaymentParameters(
                amount = Amount(BigDecimal.valueOf(value!!), Currency.getInstance("RUB")),
                title = getString(R.string.main_product_name),
                subtitle = getString(R.string.main_product_description),
                clientApplicationKey = MERCHANT_TOKEN,
                shopId = SHOP_ID,
                paymentMethodId = "2884e1fe-000f-5000-9000-1ed747d57962",
                savePaymentMethod = SavePaymentMethod.USER_SELECTS
        )
        val intent = createSavedCardTokenizeIntent(this, parameters)
        startActivityForResult(intent, REQUEST_CODE_TOKENIZE)
    }

    companion object {
        private const val REQUEST_CODE_TOKENIZE = 1
    }
}
