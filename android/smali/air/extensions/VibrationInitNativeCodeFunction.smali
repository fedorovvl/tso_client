.class public Lair/extensions/VibrationInitNativeCodeFunction;
.super Ljava/lang/Object;
.source "VibrationInitNativeCodeFunction.java"

# interfaces
.implements Lcom/adobe/fre/FREFunction;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public call(Lcom/adobe/fre/FREContext;[Lcom/adobe/fre/FREObject;)Lcom/adobe/fre/FREObject;
    .locals 4
    .param p1, "context"    # Lcom/adobe/fre/FREContext;
    .param p2, "passedArgs"    # [Lcom/adobe/fre/FREObject;

    .prologue
    .line 38
    const-string v2, "VibrationInitNativeCodeFunction"

    const-string v3, "call"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move-object v1, p1

    .line 40
    check-cast v1, Lair/extensions/VibrationExtensionContext;

    .line 42
    .local v1, "vibExtContext":Lair/extensions/VibrationExtensionContext;
    invoke-virtual {v1}, Lair/extensions/VibrationExtensionContext;->getActivity()Landroid/app/Activity;

    move-result-object v0

    .line 44
    .local v0, "a":Landroid/app/Activity;
    const-string v2, "vibrator"

    invoke-virtual {v0, v2}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/os/Vibrator;

    iput-object v2, v1, Lair/extensions/VibrationExtensionContext;->androidVibrator:Landroid/os/Vibrator;

    .line 46
    const/4 v2, 0x0

    return-object v2
.end method
