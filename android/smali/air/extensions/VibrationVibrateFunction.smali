.class public Lair/extensions/VibrationVibrateFunction;
.super Ljava/lang/Object;
.source "VibrationVibrateFunction.java"

# interfaces
.implements Lcom/adobe/fre/FREFunction;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public call(Lcom/adobe/fre/FREContext;[Lcom/adobe/fre/FREObject;)Lcom/adobe/fre/FREObject;
    .locals 8
    .param p1, "context"    # Lcom/adobe/fre/FREContext;
    .param p2, "passedArgs"    # [Lcom/adobe/fre/FREObject;

    .prologue
    .line 30
    const/4 v3, 0x0

    .line 32
    .local v3, "result":Lcom/adobe/fre/FREObject;
    const-string v5, "VibrationVibrateFunction"

    const-string v6, "call"

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move-object v4, p1

    .line 34
    check-cast v4, Lair/extensions/VibrationExtensionContext;

    .line 38
    .local v4, "vibExtContext":Lair/extensions/VibrationExtensionContext;
    const/4 v5, 0x0

    :try_start_0
    aget-object v2, p2, v5

    .line 40
    .local v2, "fro":Lcom/adobe/fre/FREObject;
    invoke-virtual {v2}, Lcom/adobe/fre/FREObject;->getAsInt()I

    move-result v0

    .line 42
    .local v0, "duration":I
    const-string v5, "VibrationVibrateFunction"

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "call: duration value is "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 44
    iget-object v5, v4, Lair/extensions/VibrationExtensionContext;->androidVibrator:Landroid/os/Vibrator;

    int-to-long v6, v0

    invoke-virtual {v5, v6, v7}, Landroid/os/Vibrator;->vibrate(J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 52
    .end local v0    # "duration":I
    .end local v2    # "fro":Lcom/adobe/fre/FREObject;
    :goto_0
    return-object v3

    .line 47
    :catch_0
    move-exception v1

    .line 49
    .local v1, "e":Ljava/lang/Exception;
    const-string v5, "VibrationVibrateFunction"

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
