.class public Lcom/adobe/air/AndroidLocale;
.super Ljava/lang/Object;
.source "AndroidLocale.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/AndroidLocale$STRING_ID;
    }
.end annotation


# static fields
.field private static final ANDROID_LOCALE_TAG:Ljava/lang/String; = "AndroidLocale"

.field private static final LANG_ENGLISH:Ljava/lang/String; = "en"

.field private static final MAX_LOCALE_NAME_SIZE:I = 0xa


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static GetLocale()Ljava/lang/String;
    .locals 5

    .prologue
    .line 44
    const-string v3, "en"

    .line 45
    .local v3, "language":Ljava/lang/String;
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    .line 46
    .local v1, "defaultLocale":Ljava/util/Locale;
    if-eqz v1, :cond_0

    .line 48
    invoke-virtual {v1}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v2

    .line 49
    .local v2, "lang":Ljava/lang/String;
    if-eqz v2, :cond_0

    .line 53
    const-string v4, "zh"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 55
    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v4, 0xa

    invoke-direct {v0, v4}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 56
    .local v0, "builder":Ljava/lang/StringBuilder;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 57
    const-string v4, "_"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 58
    invoke-virtual {v1}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 59
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 68
    .end local v0    # "builder":Ljava/lang/StringBuilder;
    .end local v2    # "lang":Ljava/lang/String;
    :cond_0
    :goto_0
    return-object v3

    .line 63
    .restart local v2    # "lang":Ljava/lang/String;
    :cond_1
    move-object v3, v2

    goto :goto_0
.end method

.method public static GetLocalizedString(Lcom/adobe/air/AndroidLocale$STRING_ID;)Ljava/lang/String;
    .locals 2
    .param p0, "id"    # Lcom/adobe/air/AndroidLocale$STRING_ID;

    .prologue
    .line 39
    invoke-virtual {p0}, Lcom/adobe/air/AndroidLocale$STRING_ID;->ordinal()I

    move-result v0

    invoke-static {}, Lcom/adobe/air/AndroidLocale;->GetLocale()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/adobe/air/AndroidLocale;->getLocalString(ILjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static native getLocalString(ILjava/lang/String;)Ljava/lang/String;
.end method
