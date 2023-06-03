.class public Lcom/adobe/air/AndroidInputManager;
.super Ljava/lang/Object;
.source "AndroidInputManager.java"

# interfaces
.implements Landroid/hardware/input/InputManager$InputDeviceListener;
.implements Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;
.implements Lcom/adobe/air/AndroidActivityWrapper$InputEventCallback;


# static fields
.field private static sAndroidInputManager:Lcom/adobe/air/AndroidInputManager;


# instance fields
.field private mContext:Landroid/content/Context;

.field private mInputDevices:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray",
            "<",
            "Lcom/adobe/air/AndroidInputDevice;",
            ">;"
        }
    .end annotation
.end field

.field private mInputManager:Landroid/hardware/input/InputManager;

.field private mInternalReference:J

.field private mListening:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 40
    const/4 v0, 0x0

    sput-object v0, Lcom/adobe/air/AndroidInputManager;->sAndroidInputManager:Lcom/adobe/air/AndroidInputManager;

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 4
    .param p1, "c"    # Landroid/content/Context;

    .prologue
    const/4 v1, 0x0

    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    iput-object v1, p0, Lcom/adobe/air/AndroidInputManager;->mContext:Landroid/content/Context;

    .line 42
    iput-object v1, p0, Lcom/adobe/air/AndroidInputManager;->mInputManager:Landroid/hardware/input/InputManager;

    .line 43
    iput-object v1, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    .line 44
    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lcom/adobe/air/AndroidInputManager;->mInternalReference:J

    .line 45
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/adobe/air/AndroidInputManager;->mListening:Z

    .line 78
    iput-object p1, p0, Lcom/adobe/air/AndroidInputManager;->mContext:Landroid/content/Context;

    .line 79
    iget-object v1, p0, Lcom/adobe/air/AndroidInputManager;->mContext:Landroid/content/Context;

    if-eqz v1, :cond_0

    .line 81
    iget-object v1, p0, Lcom/adobe/air/AndroidInputManager;->mContext:Landroid/content/Context;

    const-string v2, "input"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/hardware/input/InputManager;

    iput-object v1, p0, Lcom/adobe/air/AndroidInputManager;->mInputManager:Landroid/hardware/input/InputManager;

    .line 84
    :cond_0
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    .line 85
    .local v0, "actWrapper":Lcom/adobe/air/AndroidActivityWrapper;
    if-eqz v0, :cond_1

    .line 87
    invoke-virtual {v0, p0}, Lcom/adobe/air/AndroidActivityWrapper;->addActivityStateChangeListner(Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;)V

    .line 88
    invoke-virtual {v0, p0}, Lcom/adobe/air/AndroidActivityWrapper;->addInputEventListner(Lcom/adobe/air/AndroidActivityWrapper$InputEventCallback;)V

    .line 90
    :cond_1
    new-instance v1, Landroid/util/SparseArray;

    invoke-direct {v1}, Landroid/util/SparseArray;-><init>()V

    iput-object v1, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    .line 91
    return-void
.end method

.method public static GetAndroidInputManager(Landroid/content/Context;)Lcom/adobe/air/AndroidInputManager;
    .locals 1
    .param p0, "c"    # Landroid/content/Context;

    .prologue
    .line 69
    invoke-static {}, Lcom/adobe/air/AndroidInputManager;->isSupported()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/adobe/air/AndroidInputManager;->sAndroidInputManager:Lcom/adobe/air/AndroidInputManager;

    if-nez v0, :cond_0

    .line 71
    new-instance v0, Lcom/adobe/air/AndroidInputManager;

    invoke-direct {v0, p0}, Lcom/adobe/air/AndroidInputManager;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/adobe/air/AndroidInputManager;->sAndroidInputManager:Lcom/adobe/air/AndroidInputManager;

    .line 73
    :cond_0
    sget-object v0, Lcom/adobe/air/AndroidInputManager;->sAndroidInputManager:Lcom/adobe/air/AndroidInputManager;

    return-object v0
.end method

.method private native OnDeviceAdded(JLcom/adobe/air/AndroidInputDevice;Ljava/lang/String;)V
.end method

.method private native OnDeviceRemoved(JLjava/lang/String;)V
.end method

.method private addRemoveExistingInputDevices()V
    .locals 8

    .prologue
    .line 136
    iget-object v5, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    invoke-virtual {v5}, Landroid/util/SparseArray;->size()I

    move-result v4

    .line 137
    .local v4, "size":I
    const/4 v2, 0x0

    .local v2, "index":I
    :goto_0
    if-ge v2, v4, :cond_3

    .line 139
    iget-object v5, p0, Lcom/adobe/air/AndroidInputManager;->mInputManager:Landroid/hardware/input/InputManager;

    invoke-virtual {v5}, Landroid/hardware/input/InputManager;->getInputDeviceIds()[I

    move-result-object v1

    .line 140
    .local v1, "deviceIds":[I
    const/4 v3, 0x0

    .line 141
    .local v3, "num":I
    const/4 v3, 0x0

    :goto_1
    array-length v5, v1

    if-ge v3, v5, :cond_0

    .line 143
    iget-object v5, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    invoke-virtual {v5, v2}, Landroid/util/SparseArray;->keyAt(I)I

    move-result v5

    aget v6, v1, v3

    if-ne v5, v6, :cond_2

    .line 149
    :cond_0
    array-length v5, v1

    if-ne v3, v5, :cond_1

    .line 151
    iget-object v5, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    invoke-virtual {v5, v2}, Landroid/util/SparseArray;->valueAt(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidInputDevice;

    .line 152
    .local v0, "device":Lcom/adobe/air/AndroidInputDevice;
    iget-wide v6, p0, Lcom/adobe/air/AndroidInputManager;->mInternalReference:J

    invoke-virtual {v0}, Lcom/adobe/air/AndroidInputDevice;->getUniqueId()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v6, v7, v5}, Lcom/adobe/air/AndroidInputManager;->OnDeviceRemoved(JLjava/lang/String;)V

    .line 153
    iget-object v5, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    iget-object v6, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    invoke-virtual {v6, v2}, Landroid/util/SparseArray;->keyAt(I)I

    move-result v6

    invoke-virtual {v5, v6}, Landroid/util/SparseArray;->delete(I)V

    .line 137
    .end local v0    # "device":Lcom/adobe/air/AndroidInputDevice;
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 141
    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 158
    .end local v1    # "deviceIds":[I
    .end local v3    # "num":I
    :cond_3
    iget-object v5, p0, Lcom/adobe/air/AndroidInputManager;->mInputManager:Landroid/hardware/input/InputManager;

    invoke-virtual {v5}, Landroid/hardware/input/InputManager;->getInputDeviceIds()[I

    move-result-object v1

    .line 159
    .restart local v1    # "deviceIds":[I
    const/4 v2, 0x0

    :goto_2
    array-length v5, v1

    if-ge v2, v5, :cond_4

    .line 161
    aget v5, v1, v2

    invoke-virtual {p0, v5}, Lcom/adobe/air/AndroidInputManager;->onInputDeviceAdded(I)V

    .line 159
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 163
    :cond_4
    return-void
.end method

.method public static isSupported()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 51
    :try_start_0
    const-string v2, "android.hardware.input.InputManager"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    if-eqz v2, :cond_0

    .line 53
    const/4 v1, 0x1

    .line 63
    .local v0, "e":Ljava/lang/Exception;
    :cond_0
    :goto_0
    return v1

    .line 60
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_0
    move-exception v0

    .line 63
    .restart local v0    # "e":Ljava/lang/Exception;
    goto :goto_0
.end method


# virtual methods
.method public getInputDevice(I)Lcom/adobe/air/AndroidInputDevice;
    .locals 1
    .param p1, "deviceId"    # I

    .prologue
    .line 95
    iget-object v0, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidInputDevice;

    return-object v0
.end method

.method public listenForInputDevice(Z)V
    .locals 2
    .param p1, "start"    # Z

    .prologue
    .line 108
    iget-object v0, p0, Lcom/adobe/air/AndroidInputManager;->mInputManager:Landroid/hardware/input/InputManager;

    if-nez v0, :cond_1

    .line 131
    :cond_0
    :goto_0
    return-void

    .line 115
    :cond_1
    if-eqz p1, :cond_2

    :try_start_0
    iget-boolean v0, p0, Lcom/adobe/air/AndroidInputManager;->mListening:Z

    if-nez v0, :cond_2

    .line 117
    iget-object v0, p0, Lcom/adobe/air/AndroidInputManager;->mInputManager:Landroid/hardware/input/InputManager;

    const/4 v1, 0x0

    invoke-virtual {v0, p0, v1}, Landroid/hardware/input/InputManager;->registerInputDeviceListener(Landroid/hardware/input/InputManager$InputDeviceListener;Landroid/os/Handler;)V

    .line 118
    invoke-direct {p0}, Lcom/adobe/air/AndroidInputManager;->addRemoveExistingInputDevices()V

    .line 119
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/AndroidInputManager;->mListening:Z

    goto :goto_0

    .line 127
    :catch_0
    move-exception v0

    goto :goto_0

    .line 121
    :cond_2
    if-nez p1, :cond_0

    iget-boolean v0, p0, Lcom/adobe/air/AndroidInputManager;->mListening:Z

    if-eqz v0, :cond_0

    .line 123
    iget-object v0, p0, Lcom/adobe/air/AndroidInputManager;->mInputManager:Landroid/hardware/input/InputManager;

    invoke-virtual {v0, p0}, Landroid/hardware/input/InputManager;->unregisterInputDeviceListener(Landroid/hardware/input/InputManager$InputDeviceListener;)V

    .line 124
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/AndroidInputManager;->mListening:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0
.end method

.method public onActivityStateChanged(Lcom/adobe/air/AndroidActivityWrapper$ActivityState;)V
    .locals 1
    .param p1, "state"    # Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    .prologue
    .line 239
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->RESUMED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    if-ne p1, v0, :cond_1

    .line 241
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/adobe/air/AndroidInputManager;->listenForInputDevice(Z)V

    .line 247
    :cond_0
    :goto_0
    return-void

    .line 243
    :cond_1
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->PAUSED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    if-ne p1, v0, :cond_0

    .line 245
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/adobe/air/AndroidInputManager;->listenForInputDevice(Z)V

    goto :goto_0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0
    .param p1, "config"    # Landroid/content/res/Configuration;

    .prologue
    .line 252
    return-void
.end method

.method public onGenericMotionEvent(Landroid/view/MotionEvent;)Z
    .locals 3
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    .line 224
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getSource()I

    move-result v1

    and-int/lit8 v1, v1, 0x10

    if-eqz v1, :cond_0

    .line 225
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v1

    const/4 v2, 0x2

    if-ne v1, v2, :cond_0

    .line 227
    iget-object v1, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getDeviceId()I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidInputDevice;

    .line 228
    .local v0, "device":Lcom/adobe/air/AndroidInputDevice;
    if-eqz v0, :cond_0

    .line 230
    invoke-virtual {v0, p1}, Lcom/adobe/air/AndroidInputDevice;->onGenericMotionEvent(Landroid/view/MotionEvent;)Z

    move-result v1

    .line 233
    .end local v0    # "device":Lcom/adobe/air/AndroidInputDevice;
    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public onInputDeviceAdded(I)V
    .locals 5
    .param p1, "deviceId"    # I

    .prologue
    .line 168
    iget-object v2, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    invoke-virtual {v2, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidInputDevice;

    .line 169
    .local v0, "device":Lcom/adobe/air/AndroidInputDevice;
    if-nez v0, :cond_0

    .line 171
    iget-object v2, p0, Lcom/adobe/air/AndroidInputManager;->mInputManager:Landroid/hardware/input/InputManager;

    invoke-virtual {v2, p1}, Landroid/hardware/input/InputManager;->getInputDevice(I)Landroid/view/InputDevice;

    move-result-object v1

    .line 172
    .local v1, "inputDevice":Landroid/view/InputDevice;
    invoke-virtual {v1}, Landroid/view/InputDevice;->isVirtual()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {v1}, Landroid/view/InputDevice;->getSources()I

    move-result v2

    and-int/lit8 v2, v2, 0x10

    if-eqz v2, :cond_0

    .line 173
    invoke-virtual {v1}, Landroid/view/InputDevice;->getSources()I

    move-result v2

    and-int/lit8 v2, v2, 0x1

    if-eqz v2, :cond_0

    .line 175
    new-instance v0, Lcom/adobe/air/AndroidInputDevice;

    .end local v0    # "device":Lcom/adobe/air/AndroidInputDevice;
    invoke-direct {v0, v1}, Lcom/adobe/air/AndroidInputDevice;-><init>(Landroid/view/InputDevice;)V

    .line 178
    .restart local v0    # "device":Lcom/adobe/air/AndroidInputDevice;
    iget-object v2, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    invoke-virtual {v2, p1, v0}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 179
    iget-wide v2, p0, Lcom/adobe/air/AndroidInputManager;->mInternalReference:J

    invoke-virtual {v0}, Lcom/adobe/air/AndroidInputDevice;->getUniqueId()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v2, v3, v0, v4}, Lcom/adobe/air/AndroidInputManager;->OnDeviceAdded(JLcom/adobe/air/AndroidInputDevice;Ljava/lang/String;)V

    .line 182
    .end local v1    # "inputDevice":Landroid/view/InputDevice;
    :cond_0
    return-void
.end method

.method public onInputDeviceChanged(I)V
    .locals 0
    .param p1, "deviceId"    # I

    .prologue
    .line 203
    invoke-virtual {p0, p1}, Lcom/adobe/air/AndroidInputManager;->onInputDeviceRemoved(I)V

    .line 204
    invoke-virtual {p0, p1}, Lcom/adobe/air/AndroidInputManager;->onInputDeviceAdded(I)V

    .line 205
    return-void
.end method

.method public onInputDeviceRemoved(I)V
    .locals 4
    .param p1, "deviceId"    # I

    .prologue
    .line 187
    iget-object v1, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    invoke-virtual {v1, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidInputDevice;

    .line 188
    .local v0, "device":Lcom/adobe/air/AndroidInputDevice;
    if-eqz v0, :cond_0

    .line 192
    iget-wide v2, p0, Lcom/adobe/air/AndroidInputManager;->mInternalReference:J

    invoke-virtual {v0}, Lcom/adobe/air/AndroidInputDevice;->getUniqueId()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v2, v3, v1}, Lcom/adobe/air/AndroidInputManager;->OnDeviceRemoved(JLjava/lang/String;)V

    .line 194
    iget-object v1, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    invoke-virtual {v1, p1}, Landroid/util/SparseArray;->delete(I)V

    .line 196
    :cond_0
    return-void
.end method

.method public onKeyEvent(Landroid/view/KeyEvent;)Z
    .locals 3
    .param p1, "event"    # Landroid/view/KeyEvent;

    .prologue
    .line 211
    iget-object v1, p0, Lcom/adobe/air/AndroidInputManager;->mInputDevices:Landroid/util/SparseArray;

    invoke-virtual {p1}, Landroid/view/KeyEvent;->getDeviceId()I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidInputDevice;

    .line 212
    .local v0, "device":Lcom/adobe/air/AndroidInputDevice;
    if-eqz v0, :cond_0

    .line 214
    invoke-virtual {v0, p1}, Lcom/adobe/air/AndroidInputDevice;->onKeyEvent(Landroid/view/KeyEvent;)Z

    move-result v1

    .line 216
    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setInternalReference(J)V
    .locals 1
    .param p1, "objRef"    # J

    .prologue
    .line 100
    iput-wide p1, p0, Lcom/adobe/air/AndroidInputManager;->mInternalReference:J

    .line 102
    return-void
.end method
